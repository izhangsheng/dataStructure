//
//  PriorityQueue.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/15.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class PriorityQueue<E> where E: Comparable {
    private let heap = BinaryHeap(elements: [E]())
    
    public func size() -> Int {
        heap.size()
    }

    public func isEmpty() -> Bool {
        heap.isEmpty()
    }
    
    public func clear() {
        heap.clear()
    }

    public func enQueue(_ ele: E) {
        heap.add(withElement: ele)
    }

    public func deQueue() -> E? {
        heap.remove()
    }

    public func front() -> E? {
        heap.get()
    }
}
