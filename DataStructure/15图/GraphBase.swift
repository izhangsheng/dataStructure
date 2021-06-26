//
//  GraphBase.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/5/31.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

class EdgeInfo<V>: Hashable {
    static func == (lhs: EdgeInfo<V>, rhs: EdgeInfo<V>) -> Bool {
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
    var weight: Float = 0
    
    init(_ from: V, _ to: V, _ weight: Float = 0) {
        self.from = from
        self.to = to
        self.weight = weight
    }
}

class PathInfo<V> {
    var weight: Float = 0
    let edgeInfos: LinkedList<EdgeInfo<V>> = LinkedList(first: nil, last: nil)
    init(weight: Float = 0) {
        self.weight = weight
    }
}

protocol GraphProtocal {
    associatedtype V: Hashable
    
    func edgesSize() -> Int
    func verticesSize() -> Int
    func addVertex(_ v: V)
    func addEdge(_ from: V, _ to: V)
    func addEdge(_ from: V, _ to: V, _ weight: Float)
    func removeVertex(_ v: V)
    func removeEdge(_ from: V, _ to: V)
    
    func bfs(_ begin: V, vistor: ((_ v: V?) -> Bool))
    func dfs(_ begin: V, vistor: ((_ v: V?) -> Bool))
    
    /// 最小生成树
    func mst() -> Set<EdgeInfo<V>>
    /// 拓扑排序
    func topologicalSort() -> [V]
    /// 最短路径
    /// - Parameter begin: 开始顶点
    func shortestPath(_ begin: V) -> [V: PathInfo<V>]
    func shortestPath() -> [V: [V: PathInfo<V>]]
}
