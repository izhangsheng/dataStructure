//
//  UnionFind_QU_S.swift
//  DataStructure
//
//  Created by 张胜 on 2020/6/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

/// 基于size优化

class UnionFind_QU_S: UnionFind_QU {
    private var sizes: [Int]
    
    override init(capacity: Int) {
        sizes = Array(repeating: 1, count: capacity)
        super.init(capacity: capacity)
    }
    
    /**
     * 将v1的根节点嫁接到v2的根节点上
     */
    override func union(v1: Int, v2: Int) {
        let p1 = parents[v1]
        let p2 = parents[v2]
        if p1 == p2 { return }
        
        if (sizes[p1] < sizes[p2]) {
            parents[p1] = p2;
            sizes[p2] += sizes[p1];
        } else {
            parents[p2] = p1;
            sizes[p1] += sizes[p2];
        }
    }
}
