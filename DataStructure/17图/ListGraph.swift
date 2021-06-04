//
//  ListGraph.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/5/31.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

public class ListGraph<Type, Element> where Type: Hashable, Element: Comparable {
    private var vertices: [Type: Vertex] = [:]
    private var edges: Set<Edge> = []
    
    
    private class Vertex: Hashable {
        var value: V
        var inEdges: Set<Edge> = Set()
        var outEdges: Set<Edge> = Set()
        
        init(with value: V) {
            self.value = value
        }
        
        // MARK: Equatable
        static func == (lhs: ListGraph<Type, Element>.Vertex, rhs: ListGraph<Type, Element>.Vertex) -> Bool {
            lhs.value == rhs.value
        }
        
        // MARK: Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }
    
    private class Edge: Hashable, Comparable {
        
        let from: Vertex
        let to: Vertex
        var weight: Element?
        
        init(_ from: Vertex, _ to: Vertex) {
            self.from = from
            self.to = to
        }
        
        func info() -> EdgeInfo<Type, Element> {
            EdgeInfo<Type, Element>(from.value, to.value, weight)
        }
        
        // MARK: Equatable
        static func == (lhs: ListGraph<Type, Element>.Edge, rhs: ListGraph<Type, Element>.Edge) -> Bool {
            (lhs.from == rhs.from) && (lhs.to == rhs.to)
        }
        
        // MARK: Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(from)
            hasher.combine(to)
        }
        
        // MARK: Comparable
        static func < (lhs: ListGraph<Type, Element>.Edge, rhs: ListGraph<Type, Element>.Edge) -> Bool {
            guard let _ = lhs.weight, let _ = rhs.weight else { return false }
            return lhs.weight! < rhs.weight!
        }
    }
}

extension ListGraph: GraphProtocal {
    typealias V = Type
    
    typealias W = Element
    
    func verticesSize() -> Int {
        vertices.count
    }
    
    func edgesSize() -> Int {
        edges.count
    }
    
    func addVertex(_ v: V) {
        guard vertices.keys.contains(v) else {
            return
        }
        let vertex = ListGraph<Type, Element>.Vertex(with: v)
        vertices.updateValue(vertex, forKey: v)
    }
    
    func addEdge(_ from: Type, _ to: Type) {
        addEdge(from, to, nil)
    }
    
    func addEdge(_ from: V, _ to: V, _ weight: Element?) {
        var fromVertex = vertices[from]
        if fromVertex == nil {
            fromVertex = ListGraph<Type, Element>.Vertex(with: from)
            vertices.updateValue(fromVertex!, forKey: from)
        }
        
        var toVertex = vertices[to]
        if toVertex == nil {
            toVertex = ListGraph<Type, Element>.Vertex(with: to)
            vertices.updateValue(toVertex!, forKey: to)
        }
        
        let edge = Edge(fromVertex!, toVertex!)
        edge.weight = weight
        // 之前存在该边，先删除在添加（更新权重值）
        if let _ = fromVertex?.outEdges.remove(edge) {
            toVertex?.inEdges.remove(edge)
            edges.remove(edge)
        }
        fromVertex?.outEdges.insert(edge)
        toVertex?.inEdges.insert(edge)
        edges.insert(edge)
    }
    
    func removeVertex(_ v: V) {
        let vertex = vertices.removeValue(forKey: v)
        guard let vertexNotNil = vertex else { return }
        
        /// 遍历顶点的出度，找出所有边的入度移除该边
        for outEdge in vertexNotNil.outEdges {
            outEdge.to.inEdges.remove(outEdge)
            edges.remove(outEdge)
        }
        /// 遍历顶点的入度，找出所有边的出度移除该边
        for inEdge in vertexNotNil.inEdges {
            inEdge.from.outEdges.remove(inEdge)
            edges.remove(inEdge)
        }
    }
    
    func removeEdge(_ from: V, _ to: V) {
        let fromVertex = vertices[from]
        guard let fromVertexOk = fromVertex else { return }
        
        let toVertex = vertices[to]
        guard let toVertexOk = toVertex else { return }
        
        let edge = Edge(fromVertexOk, toVertexOk)
        if let _ = fromVertexOk.outEdges.remove(edge) {
            toVertexOk.inEdges.remove(edge)
            edges.remove(edge)
        }
    }
    
    /// 广度优先搜索
    /// - Parameters:
    ///   - begin: 开始搜索顶点
    ///   - vistor: 访问器
    func bfs(_ begin: V, vistor: ((_ v: V?) -> Bool)) {
        let beginVertex = vertices[begin]
        guard let beginVertexOk = beginVertex else { return }
        
        var visitedVertices = Set<Vertex>()
        var queue = [Vertex]()
        queue.append(beginVertexOk)
        visitedVertices.insert(beginVertexOk)
        
        while !queue.isEmpty {
            let vertex = queue.removeFirst()
            if vistor(vertex.value) { return }
            for edge in vertex.outEdges {
                if (visitedVertices.contains(edge.to)) { continue }
                queue.append(edge.to)
                visitedVertices.insert(edge.to)
            }
        }
    }
    
    /// 深度优先搜索
    /// - Parameters:
    ///   - begin: 开始搜索顶点
    ///   - vistor: 访问器
    func dfs(_ begin: V, vistor: ((_ v: V?) -> Bool)) {
        let beginVertex = vertices[begin]
        guard let beginVertexOk = beginVertex else { return }
        
        var visitedVertices = Set<Vertex>()
        var stack = [Vertex]()
        
        // 先访问起点
        stack.insert(beginVertexOk, at: 0)
        visitedVertices.insert(beginVertexOk)
        if vistor(beginVertexOk.value) { return }
        
        while !stack.isEmpty {
            let vertex = stack.removeFirst()
            
            for edge in vertex.outEdges {
                if visitedVertices.contains(edge.to) { continue }
                
                stack.insert(edge.from, at: 0)
                stack.insert(edge.to, at: 0)
                visitedVertices.insert(edge.to)
                if vistor(edge.to.value) { return }
                break
            }
        }
    }
    
    /// 拓扑排序
    /// 有环直接返回空集合
    func topologicalSort() -> [V] {
        let uf = GenericUnionFind<Vertex>()
        vertices.values.forEach { (vertex) in
            uf.makeSet(v: vertex)
        }
        for edge in edges {
            // 产生环
            if (uf.isSame(v1: edge.from, v2: edge.to)) { return [] }
            uf.union(v1: edge.from, v2: edge.to)
        }
        
        var result = [V]()
        var queue = [Vertex]()
        var ins = [Vertex: Int]()
        
        // 初始化（将度为0的节点放入队列）
        vertices.forEach { (key, vertex) in
            let inCount = vertex.inEdges.count
            if inCount == 0 {
                queue.append(vertex)
            } else {
                ins[vertex] = inCount
            }
        }
        
        while !queue.isEmpty {
            let front = queue.removeFirst()
            // 放入结果中
            result.append(front.value)
            
            for edge in front.outEdges {
                var toIn = ins[edge.to]
                if toIn == nil {
                    continue
                }
                toIn! -= 1
                if toIn == 0 {
                    queue.append(edge.to)
                } else {
                    ins[edge.to] = toIn
                }
            }
        }
        return result
    }
    
    /// 最小生成树
    func mst() -> Set<EdgeInfo<V, W>> {
        return Int.random(in: 0 ... 1) == 0 ? prim() : kruskal()
    }
    
    /// prim算法：假设G=(V，E)是有权的连通图（无向），A是G中最小生成树的边集
    /// 算法从S={u0}（u0∈V），A={}开始，重复执行下述操作，直到S=V为止
    /// ✓找到切分C=(S，V–S)的最小横切边(u0，v0)并入集合A，同时将v0并入集合S
    /// - Returns: 返回最小生成树（最小支撑树）的所有边信息
    private func prim() -> Set<EdgeInfo<V, W>> {
        var iterator = vertices.values.makeIterator()
        guard let next = iterator.next() else { return [] }
        
        var edgeInfos = Set<EdgeInfo<V, W>>()
        var addedVertices = Set<Vertex>()
        addedVertices.insert(next)
        let minHeap = MinHeap<Edge>(elements: Array(next.outEdges))
        let verticesSize = vertices.count
        
        while !minHeap.isEmpty(), addedVertices.count < verticesSize {
            let edge = minHeap.remove()
            if addedVertices.contains(edge!.to) { continue }
            edgeInfos.insert(edge!.info())
            addedVertices.insert(edge!.to)
            for outEdge in edge!.to.outEdges {
                minHeap.add(withElement: outEdge)
            }
        }
        
        return edgeInfos
    }
    
    /// kruskal算法：按照边的权重（从小到大）加入到生成树种，直到生成树中含有v - 1（v是顶点数量）为止，
    /// 若加入该边会与生成树形成环，则不加入该边
    /// 从第3条边开始可能形成环
    /// - Returns: 返回最小生成树（最小支撑树）的所有边信息
    private func kruskal() -> Set<EdgeInfo<V, W>> {
        let edgeSize = vertices.count - 1
        guard edgeSize >= 0  else {
            return []
        }
        var edgeInfos = Set<EdgeInfo<V, W>>()
        let heap = MinHeap<Edge>(elements: Array(edges))
        let uf = GenericUnionFind<Vertex>()
        vertices.forEach { (key, vertex) in
            uf.makeSet(v: vertex)
        }
        while !heap.isEmpty(), edgeInfos.count < edgeSize {
            let edge = heap.remove()
            // 产生环
            if (uf.isSame(v1: edge!.from, v2: edge!.to)) { continue }
            edgeInfos.insert(edge!.info())
            uf.union(v1: edge!.from, v2: edge!.to)
        }
        
        return edgeInfos
    }
    
    /// 最短路径
    /// - Parameter begin: 开始顶点
    func shortestPath(_ begin: V) -> [V: PathInfo<V, W>] {
        return [:]
    }

    func shortestPath() -> [V: [V: PathInfo<V, W>]] {
        return [:]
    }
    
    private func dijkstra(_ begin: V) -> [V: PathInfo<V, W>]? {
        let beginVertex = vertices[begin]
        guard let _ = beginVertex else { return nil }
        
        var selectedPaths = [V: PathInfo<V, W>]()
        var paths = [Vertex: PathInfo<V, W>]()
        paths.updateValue(PathInfo(weight: nil), forKey: beginVertex!)
        
        while !paths.isEmpty {
            
        }
        
        return selectedPaths
    }
    
    private func getMinPath(paths: [Vertex: PathInfo<V, W>]) -> Dictionary<Vertex, PathInfo<V, W>>.Element {
        
        var iterator = paths.makeIterator()
        var minEntry: (key: Vertex, value: PathInfo<V, W>) = iterator.next()!
        
        while let next = iterator.next() {
            
            if next.value.weight! < minEntry.value.weight! {
                minEntry = next
            }
        }
        
        return minEntry
    }
}
