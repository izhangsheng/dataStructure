//
//  GenericUnionFind.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/6/3.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

public class GenericUnionFind<Type> where Type: Hashable {
    private class Node<V: Equatable> {
        let value: V
        var parent: GenericUnionFind.Node<V>? = nil
        var rank = 1
        init(value: V, parent: GenericUnionFind.Node<V>? = nil) {
            self.value = value
            self.parent = parent
        }
    }
    private var nodes = [Type: GenericUnionFind.Node<Type>]()
    
    // MARK: public
    public func makeSet(v: Type) {
        if nodes.keys.contains(v) { return }
        nodes.updateValue(GenericUnionFind.Node<Type>(value: v), forKey: v)
    }
    
    public func find(v: Type) -> Type? {
        let node = findNode(v: v)
        return node?.value
    }
    
    public func union(v1: Type, v2: Type) {
        let p1 = findNode(v: v1)
        let p2 = findNode(v: v2)
        if p1 == nil || p2 == nil { return }
        if p1?.value == p2?.value { return }
        
        if p1!.rank < p2!.rank {
            p1?.parent = p2!
        } else if p1!.rank > p2!.rank {
            p2?.parent = p1!
        } else {
            p1?.parent = p2!
            p2!.rank += 1
        }
    }
    
    public func isSame(v1: Type, v2: Type) -> Bool {
        return find(v: v1) == find(v: v2)
    }
    
    // MARK: private
    
    /// 找出v的根节点
    private func findNode(v: Type) -> GenericUnionFind.Node<Type>? {
        let node = nodes[v]
        guard var nodeNotNil = node else { return nil }
        while let _ = nodeNotNil.parent, nodeNotNil.value != nodeNotNil.parent?.value {
            nodeNotNil.parent = nodeNotNil.parent?.parent
            nodeNotNil = nodeNotNil.parent!
        }
        
        return nodeNotNil
    }
    
    
}
