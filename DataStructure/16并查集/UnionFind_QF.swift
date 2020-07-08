//
//  UnionFind_QF.swift
//  DataStructure
//
//  Created by 张胜 on 2020/6/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation
/// 快速查找，所有同一集合内树高都为2
public class UnionFind_QF: UnionFind {
    // 父节点就是根节点
    override public func find(v: Int) -> Int {
        rangeCheck(v: v)
        return parents[v]
    }
    
    /**
     将v1所在集合（根节点相同的元素）的所有元素，都嫁接到v2的父节点上
     */
    override public func union(v1: Int, v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)
        if p1 == p2 { return }
        for i in 0 ..< parents.count {
            if p1 == parents[i] {
                parents[i] = p2
            }
        }
    }
}
