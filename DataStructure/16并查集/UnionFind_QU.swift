//
//  UnionFind_QU.swift
//  DataStructure
//
//  Created by 张胜 on 2020/6/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

/// 快速合并（只合并两个集合树的根节点）
public class UnionFind_QU: UnionFind {
    
    // 查找比较慢，通过parent链条不断地向上找，直到找到根节点
    public override func find(v: Int) -> Int {
        rangeCheck(v: v)
        // 所有单个元素的树，初始化时自己指向自己，所以查到自己指向自己即为根节点
        var p = v
        while p != parents[p] {
            p = parents[p]
        }
        return p
    }
    
    // 将v1的根节点嫁接到v2的根节点上
    public override func union(v1: Int, v2: Int) {
        let p1 = parents[v1]
        let p2 = parents[v2]
        if p1 == p2 { return }
        parents[v1] = parents[v2]
    }
}
 
