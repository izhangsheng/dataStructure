//
//  DeQueue.swift
//  DataStructure
//
//  Created by 张胜 on 2019/12/2.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class DeQueue<T: Comparable> {
    private let list = LinkedList<T>(first: nil, last: nil)
    
    func size() -> Int {
        list.size()
    }
    
    func isEmpty() -> Bool {
        list.isEmpty()
    }
    
    func clear() {
        list.clear()
    }
    
    func enQueueRear(ele: T) {
        list.add(ele: ele)
    }
    
    func enQueueFront(ele: T) {
        list.add(ele: ele, idx: 0)
    }
    
    func deQueueRear() -> T? {
        list.remove(idx: size() - 1)
    }
    
    func deQueueFront() -> T? {
        list.remove(idx: 0)
    }
    
    func front() -> T? {
        list.get(idx: 0)
    }
    
    func rear() -> T? {
        list.get(idx: size() - 1)
    }
}
