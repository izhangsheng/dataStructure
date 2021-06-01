//
//  ListGraph.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/5/31.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

public class ListGraph<Type: AnyObject, Element> where Type: Hashable, Element: Comparable {
    private var vertices: [Type: Vertex] = [:]
    private var edges: Set<Edge> = []
    
    
    private class Vertex: Hashable {
        var value: V?
        var inEdges: Set<Edge> = Set()
        var outEdges: Set<Edge> = Set()
        
        init(with value: V) {
            self.value = value
        }
        
        // MARK: Equatable
        static func == (lhs: ListGraph<Type, Element>.Vertex, rhs: ListGraph<Type, Element>.Vertex) -> Bool {
            lhs.value === rhs.value
        }
        
        // MARK: Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }
    
    private class Edge: Hashable {
        var from: Vertex
        var to: Vertex
        var weight: Element?
        
        init(_ from: Vertex, _ to: Vertex) {
            self.from = from
            self.to = to
        }
        
        // MARK: Equatable
        static func == (lhs: ListGraph<Type, Element>.Edge, rhs: ListGraph<Type, Element>.Edge) -> Bool {
            (lhs.from === rhs.from) && (lhs.to === rhs.to)
        }
        
        // MARK: Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(from)
            hasher.combine(to)
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
        guard vertices.contains(where: { (key, value) -> Bool in
            key == v
        }) else {
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
        if let _ = fromVertex?.outEdges.remove(edge) {
            toVertex?.inEdges.remove(edge)
            edges.remove(edge)
        }
        fromVertex?.outEdges.insert(edge)
        toVertex?.inEdges.insert(edge)
        edges.insert(edge)
    }
    
    func removeVertex(_ v: V) {
        
    }
    
    func removeEdge(_ from: V, _ to: V) {
        
    }
    
    func bfs(_ begin: V, vistor: ((_ v: V) -> Void)) {
        
    }
    
    func dfs(_ begin: V, vistor: ((_ v: V) -> Void)) {
        
    }
    
    /// 最小生成树
    func mst() -> Set<EdgeInfo<V, W>> {
        return []
    }
    
    /// 拓扑排序
    func topologicalSort() -> [V] {
        return []
    }
    
    /// 最短路径
    /// - Parameter begin: 开始顶点
    func shortestPath(_ begin: V) -> [V: PathInfo<V, W>] {
        return [:]
    }

    func shortestPath() -> [V: [V: PathInfo<V, W>]] {
        return [:]
    }
}
