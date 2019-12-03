//
//  CircleQueue.swift
//  DataStructure
//
//  Created by 张胜 on 2019/12/2.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class CircleQueue<T: Equal> {
    private let defualt_capacity = 10
    
    private var front: Int = 0 // 记录第一个元素的下标
    private var count: Int = 0
    private var elements: [T?] = [T?]()
    
    func size() -> Int {
        count
    }
    
    func isEmpty() -> Bool {
        count == 0
    }
    
    func clear() {
        elements.removeAll()
        front = 0
        count = 0
    }
    
    func enQueue(ele: T) {
        ensureCapacity(capacity: count + 1)
        
//        elements[((front + count) % defualt_capacity)] = ele
        elements[index(idx: count)] = ele
        count += 1
    }
    
    func deQueue() -> T? {
        let frontEle = elements[front]
        elements[front] = nil
//        front = ((front + 1) % elements.count)
        front = index(idx: 1)
        count -= 1
        return frontEle
    }

    func frontElement() -> T? {
        elements[front]
    }
}

fileprivate extension CircleQueue {
    func index(idx: Int) -> Int {
        let newIdx = idx + front
        return newIdx - (newIdx >= elements.count ? elements.count : 0)
    }
    
    func ensureCapacity(capacity: Int) {
        let oldCapacity = elements.count
        guard oldCapacity <= capacity else {
            return
        }
        
        // 新容量为旧容量的1.5倍
//        let newCapacity = oldCapacity + (oldCapacity >> 1)
        elements = Array(elements)
        // 重置front
        front = 0;
    }
}
