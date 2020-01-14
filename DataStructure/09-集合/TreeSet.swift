//
//  TreeSet.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/13.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class TreeSet<T: Comparable>: SetProtocal {
    private let tree = RedBlackTree<T>(root: nil)
    
    typealias Element = T
    
    func size() -> Int {
        tree.count
    }
    
    func isEmpty() -> Bool {
        tree.isEmpty()
    }
    
    func clear() {
        tree.clear()
    }
    
    func contain(ele: T) -> Bool {
        tree.contain(ele: ele)
    }
    
    func add(ele: T) {
        tree.add(ele: ele)
    }
    
    func remove(ele: T) {
        tree.remove(ele: ele)
    }
    
    func traversal(visitor: @escaping((T) -> Bool)) {
        tree.inorder(visitor: visitor)
    }
}
