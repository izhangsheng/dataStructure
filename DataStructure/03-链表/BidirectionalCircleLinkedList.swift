//
//  BidirectionalCircleLinkedList.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/17.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public class BidirectionalCircleLinkedList<Type>: List {
    public var ELEMENT_NOT_FOUND: Int = -1
    
    public var count: Int = 0
    
    public func clear() {
        first = nil
        last = nil
        count = 0
    }
    
    public func get(idx: Int) -> Type? {
        rangeOfCheck(idx: idx)
        
        return getNode(idx: idx)?.data
    }
    
    public func set(ele: Type?, idx: Int) -> Type? {
        rangeOfCheck(idx: idx)
        let oldNode: BidirectionalNode? = getNode(idx: idx)
        oldNode?.data = ele
        
        return oldNode?.data
    }
    
    public func add(ele: Type?, idx: Int) {
        rangeOfCheckForAdd(idx: idx)
        if idx == count {
            // 往最后一个位置添加元素
            let oldLast = last
            let last = BidirectionalNode(pre: oldLast, next: first, data: ele)
            if oldLast == nil {
                // 添加的第一个元素
                first = last
                first?.next = first
                first?.pre = first
            } else {
                oldLast?.next = last
                first?.pre = last
            }
        } else {
            let curNode = getNode(idx: idx)
            let newNode = BidirectionalNode(pre: curNode?.pre, next: curNode, data: ele)
            curNode?.pre = newNode
            if idx == 0 {
                // 第一个
                first = newNode
            }
            
        }
        
        count += 1
    }
    
    public func remove(idx: Int) -> Type? {
        remove(node: getNode(idx: idx))
    }
    
    public func indexOf(ele: Type?) -> Int {
        var node = first
        if ele == nil {
            for i in 0 ..< count {
                if node?.data == nil {
                    return i
                }
                node = node?.next
            }
        } else {
            for i in 0 ..< count {
                let result = node?.compare(v2: ele, compareClosure: { () -> Bool in
                    true
                })
                if let _ = result {
                    return i
                }
                node = node?.next
            }
        }
        return ELEMENT_NOT_FOUND
    }
    
    public typealias T = Type
    
    
    private var first: BidirectionalNode<Type>?
    private var last: BidirectionalNode<Type>?
    init(first: BidirectionalNode<Type>?, last: BidirectionalNode<Type>?) {
        self.first = first
        self.last = last
    }
}

fileprivate extension BidirectionalCircleLinkedList {
    func getNode(idx: Int) -> BidirectionalNode<Type>? {
        if idx < (count >> 1) {
            var node: BidirectionalNode<Type>? = first
            for _ in 0 ..< idx {
                node = node?.next;
            }
            return node;
        } else {
           var node: BidirectionalNode<Type>? = last
            var i = count - 1
            while i > idx {
                node = node?.pre
                i -= 1
            }
            return node;
        }
    }
    
    func remove(node: BidirectionalNode<Type>?) -> Type? {
        if count == 1 {
            first = nil
            last = nil
        } else {
            let pre = node?.pre
            let next = node?.next
            pre?.next = next
            next?.pre = pre
            
//            if (node == first) { // index == 0
//                first = next;
//            }
//
//            if (node == last) { // index == size - 1
//                last = prev;
//            }
            
            let result = node?.compare(v2: first?.data, compareClosure: { () -> Bool in
                true
            })
            if let _ = result {
                first = next
            }
            
            if node?.compare(v2: last?.data, compareClosure: { () -> Bool in
                true
            }) ?? false { // 最后一个元素
                last = pre
            }
        }
        count -= 1
        return node?.data
    }
}
