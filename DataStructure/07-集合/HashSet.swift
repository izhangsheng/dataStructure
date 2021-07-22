//
//  HashSet.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/14.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class HashSet<T: Hashable>: SetProtocal {
    typealias Element = T
    
    var a: Dictionary = [String: T]()
    private let hashMap = HashMap<T, String>()
    private let placeholder = ""
    
    func size() -> Int {
        hashMap.size()
    }
    
    func isEmpty() -> Bool {
        hashMap.isEmpty()
    }
    
    func clear() {
        hashMap.clear()
    }
    
    func contain(ele: T) -> Bool {
        hashMap.containKey(key: ele)
    }
    
    func add(ele: T) {
        hashMap.set(forKey: ele, value: placeholder)
    }
    
    func remove(ele: T) {
        hashMap.remove(forKey: ele)
    }
    
    func traversal(visitor: @escaping((T) -> Bool)) {
        hashMap.traversal { (key, value) in
            visitor(key)
        }
    }
}
