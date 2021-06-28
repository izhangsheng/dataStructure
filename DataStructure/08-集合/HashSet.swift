//
//  HashSet.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/14.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class HashSet<T: Equatable>: SetProtocal {
    typealias Element = T
    
    var a: Dictionary = [String: T]()
    private let hashMap = HashMap<String, T>()
    
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
        hashMap.containValue(value: ele)
    }
    
    func add(ele: T) {
//        hashMap.set(forKey: <#T##String#>, value: <#T##Equatable#>)
    }
    
    func remove(ele: T) {
//        hashMap.remove(forKey: <#T##String#>)
    }
    
    func traversal(visitor: @escaping((T) -> Bool)) {
        hashMap.traversal { (key, value) in
            visitor(value)
        }
    }
}
