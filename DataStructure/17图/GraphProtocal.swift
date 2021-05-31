//
//  GraphProtocal.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/5/31.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

protocol WeightManager {
    associatedtype W
    func compare(_ w1: W, _ w2: W) -> Int
    func add(_ w1: W, _ w2: W) -> W
    func zero()
}

class EdgeInfo<V, W>: Hashable {
    static func == (lhs: EdgeInfo<V, W>, rhs: EdgeInfo<V, W>) -> Bool {
        return lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        let fromP = withUnsafePointer(to: &from) { (point) -> UnsafePointer<V> in
            return point
        }
        let toP = withUnsafePointer(to: &to) { (point) -> UnsafePointer<V> in
            return point
        }
        let weightP = withUnsafePointer(to: &weight, { $0 })
        hasher.combine(bytes: UnsafeRawBufferPointer(start: fromP, count: 1))
        hasher.combine(bytes: UnsafeRawBufferPointer(start: toP, count: 1))
        hasher.combine(bytes: UnsafeRawBufferPointer(start: weightP, count: 1))
    }
    
    var from: V
    var to: V
    var weight: W
    
    init(_ from: V, _ to: V, _ weight: W) {
        self.from = from
        self.to = to
        self.weight = weight
    }
}

class PathInfo<V, W> {
    var weight: W?
    let edgeInfos: LinkedList<EdgeInfo<V, W>> = LinkedList(first: nil, last: nil)
    init(weight: W? = nil) {
        self.weight = weight
    }
}

protocol GraphProtocal {
    associatedtype V: Hashable
    associatedtype W
    
    func edgesSize() -> Int
    func verticesSize() -> Int
    func addVertex()
    func addEdge(_ from: V, _ to: V)
    func addEdge(_ from: V, _ to: V, _ weight: W)
    func removeVertex(_ v: V)
    func removeEdge(_ from: V, _ to: V)
    
    func bfs(_ begin: V, vistor: ((_ v: V) -> Void))
    func dfs(_ begin: V, vistor: ((_ v: V) -> Void))
    
    /// 最小生成树
    func mst() -> Set<EdgeInfo<V, W>>
    /// 拓扑排序
    func topologicalSort() -> [V]
    /// 最短路径
    /// - Parameter begin: 开始顶点
    func shortestPath(_ begin: V) -> [V: PathInfo<V, W>]
    func shortestPath() -> [V: [V: PathInfo<V, W>]]
    
}
