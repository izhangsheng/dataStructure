//
//  CircleDeQueue.swift
//  DataStructure
//
//  Created by 张胜 on 2019/12/3.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class CircleDeQueue<T: Equal> {
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
    
    func enQueueRear(ele: T) {
        ensureCapacity(capacity: count + 1)
                
        elements[index(idx: count)] = ele
        count += 1
    }
    
    func enQueueFront(ele: T) {
        ensureCapacity(capacity: count + 1)
        front = index(idx: -1)
        elements[front] = ele
        count += 1
    }
    
    func deQueueFront() -> T? {
        let frontEle = elements[front]
        elements[front] = nil
//        front = ((front + 1) % elements.count)
        front = index(idx: 1)
        count -= 1
        return frontEle
    }
    
    func deQueueRear() -> T? {
        let rearIdx = index(idx: count - 1)
        let ele = elements[rearIdx]
        count -= 1
        return ele
    }

    func frontElement() -> T? {
        elements[front]
    }
    
    func rearElement() -> T? {
        elements[index(idx: count - 1)]
    }
}

fileprivate extension CircleDeQueue {
    func index(idx: Int) -> Int {
        let newIdx = idx + front
        if newIdx < 0 {
            return newIdx + elements.count
        }
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
