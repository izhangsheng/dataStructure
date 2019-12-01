//
//  Stack.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/23.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class Stack<Type: Equal> {
    private let list: ArrayList = ArrayList<Type>(capacity: 100)
    
    func clear() {
        list.clear()
    }
    
    func push(ele: Type) {
        list.add(ele)
    }
    
    func pop() -> Type? {
        list.remove(at: list.size() - 1)
    }
    
    func isEmpty() -> Bool {
        list.isEmpty()
    }
    
    func size() -> Int {
        list.size()
    }
    
    func top() -> Type? {
        list.get(idx: list.size() - 1)
    }
}
