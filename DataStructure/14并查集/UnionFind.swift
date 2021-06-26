//
//  UnionFind.swift
//  DataStructure
//
//  Created by 张胜 on 2020/6/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class UnionFind {
    var parents: [Int]
    
    public init(capacity: Int) {
        parents = Array()
        for i in 0 ... capacity {
            parents[i] = i
        }
    }
    
    /**
     * 查找v所属的集合（根节点）
     * @param v
     * @return
     */
    public func find(v: Int) -> Int { return 0 }
    
    /**
     * 合并v1、v2所在的集合
     */
    public func union(v1: Int, v2: Int) {  };
    
    /// 检查v1、v2是否属于同一个集合
    /// - Parameters:
    ///   - v1: parameter 1
    ///   - v2: parameter 2
    /// - Returns: bool
    public func isSame(v1: Int, v2: Int) -> Bool {
        return find(v: v1) == find(v: v2)
    }
    
    func rangeCheck(v: Int) {
        if (v < 0 || v >= parents.count) {
            fatalError("v is out of bounds")
        }
    }
}
