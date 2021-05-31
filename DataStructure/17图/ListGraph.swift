//
//  ListGraph.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/5/31.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

class ListGraph<Type, Element> where Type: Hashable {
    
}

extension ListGraph: GraphProtocal {
    typealias V = Type
    
    typealias W = Element
    
    func verticesSize() -> Int {
        1
    }
    
    func edgesSize() -> Int {
        1
    }
    
    func addVertex() {
        
    }
    
    func addEdge(_ from: V, _ to: V) {
        
    }
    
    func addEdge(_ from: V, _ to: V, _ weight: W) {
        
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
