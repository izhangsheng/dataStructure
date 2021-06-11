//
//  SingleCircleLinkedList.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/17.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public class SingleNode<T>: Comparetor {
    public func compare(v2: T?, compareClosure: @escaping () -> Bool) -> Bool {
        true
    }
    
    public var next: SingleNode<T>?
    public var data: T?
    public init(data: T?, next: SingleNode?) {
        self.data = data
        self.next = next
    }
}

public class SingleCircleLinkedList<Type>: List {
    // MARK: 实现协议
    public var ELEMENT_NOT_FOUND: Int = -1
    
    public var count: Int = 0
    
    public func clear() {
        first = nil
        count = 0
    }
    
    public func add(ele: Type?, idx: Int) {
        rangeOfCheckForAdd(idx: idx)
        
        let node = SingleNode(data: ele, next: nil)
        
        if idx == 0 {
            // 空的链表
            let newFirst = SingleNode(data: ele, next: first)
            let last = count == 0 ? newFirst : getNode(idx: count - 1)
            last?.next = newFirst
            first = newFirst
        } else {
            let preNode = getNode(idx: idx - 1)
            node.next = preNode?.next?.next
            preNode?.next = node
        }
        
        count += 1
    }
    
    public func get(idx: Int) -> Type? {
        getNode(idx: idx)?.data
    }
    
    public func set(ele: Type?, idx: Int) -> Type? {
        let oldNode = getNode(idx: idx)
        oldNode?.data = ele
        
        return oldNode?.data
    }
    
    public func remove(idx: Int) -> Type? {
        rangeOfCheck(idx: idx)
        var oldNode: SingleNode<Type>?
        
        if idx == 0 {
            // 删除第一个元素
            oldNode = first
            if count == 1 {
                first = nil
            } else {
                first = first?.next
                let tailNode: SingleNode? = getNode(idx: (count - 1))
                tailNode?.next = first
            }
        } else {
            let preNode: SingleNode? = getNode(idx: idx - 1)
            oldNode = preNode?.next
            let currtNode: SingleNode? = preNode?.next
            preNode?.next = currtNode?.next
        }
        
        count -= 1
        return oldNode?.data
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
    
    public var first: SingleNode<Type>?
    
    
    
    init(first: SingleNode<Type>?) {
        self.first = first
    }
}

fileprivate extension SingleCircleLinkedList {
    func getNode(idx: Int) -> SingleNode<Type>? {
        rangeOfCheck(idx: idx)
        
        var node = first
        
        for _ in 0 ..< idx {
            node = node?.next
        }
        
        return node
    }
}
