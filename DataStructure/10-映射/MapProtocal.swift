//
//  MapProtocal.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/13.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

protocol MapProtocal {
    associatedtype Key
    associatedtype Value
    
    func set(forKey k: Key, value v: Value) -> Value?
    func get(forKey k: Key) -> Value?
    func size() -> Int
    func allKeys() -> [Key]
    func allValues() -> [Value] 
    func isEmpty() -> Bool
    func remove(forKey k: Key) -> Value?
    func containKey(key: Key) -> Bool
    func containValue(value: Value) -> Bool
    func traversal(visitor: @escaping((Key, Value) -> Bool))
    func clear() -> Void
}
