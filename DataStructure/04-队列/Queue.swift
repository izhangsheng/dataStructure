//
//  Queue.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/23.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

/// 用链表实现队列，只用首尾，时间复杂度为O(1)
class Queue<T: Comparable> {
    
    private let list: LinkedList = LinkedList<T>(first: nil, last: nil)
    
    func clear() {
        list.clear()
    }
    
    func size() -> Int {
        list.size()
    }
    
    func enQueue(ele: T) {
        list.add(ele: ele)
    }
    
    func deQueue() -> T? {
        list.remove(idx: list.size() - 1)
    }
    
    func front() -> T? {
        list.first?.data
    }
    
    func isEmpty() -> Bool {
        list.isEmpty()
    }
}

