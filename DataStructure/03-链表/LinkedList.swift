//
//  LinkedList.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/17.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public class ListNode<Element> {
    public var val: Int
    public var next: ListNode<Element>?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

public class BidirectionalNode<T>: Comparetor {
    public typealias T = T
    
    public func compare(v2: T?, compareClosure: @escaping() -> Bool) -> Bool {
        true
    }
    
    var data: T?
    var pre: BidirectionalNode?
    var next: BidirectionalNode?
    init(pre: BidirectionalNode?, next: BidirectionalNode?, data: T?) {
        self.data = data
        self.pre = pre
        self.next = next
    }
}

public class LinkedList<T>: List {
    // MARK: 实现协议
    public var ELEMENT_NOT_FOUND: Int = -1
    
    public var count: Int = 0
    
    public func clear() {
        count = 0
        first = nil
        last = nil
    }
    
    public func add(ele: T?) {
        add(ele: ele, idx: count)
    }
    
    public func get(idx: Int) -> T? {
        getNode(idx: idx)?.data
    }
    
    @discardableResult public func set(ele: T?, idx: Int) -> T? {
        let curNode = getNode(idx: idx)
        let oldData = curNode?.data
        curNode?.data = ele
        return oldData
    }
    
    /// 链表特有
    /// - Parameter ele: 添加的数据
    /// - Parameter idx: 在某一位置
    public func add(ele: T?, idx: Int) {
        rangeOfCheckForAdd(idx: idx)
        
        if idx == count {
            let oldLast = last
            last = BidirectionalNode(pre: oldLast, next: nil, data: ele)
            if oldLast == nil {
                // 这是链表第一个元素
                first = last
            } else {
                oldLast?.next = last
            }
        } else {
            let next: BidirectionalNode? = getNode(idx: idx)
            let pre = next?.pre
            let node = BidirectionalNode(pre: pre, next: next, data: ele)
            
            next?.pre = node
            if pre == nil {
                first = node
            } else {
                pre?.next = node
            }
        }
        
        count += 1
    }
    
    @discardableResult public func remove(idx: Int) -> T? {
            rangeOfCheck(idx: idx)
            
            let node = getNode(idx: idx)
            let pre = node?.pre
            let next = node?.next
            
            if pre == nil {
    //            next?.pre = nil 下面else里设置了
                first = next
            } else {
                pre?.next = next
            }
            
            if next == nil {
    //            pre?.next = nil 上面else里设置了
                last = pre
            } else {
                next?.pre = pre
            }
            
            count -= 1
            
            return node?.data
        }
    
    public func indexOf(ele: T?) -> Int {
        if ele == nil {
            var node = first
            for i in 0 ..< count {
                if node?.data == nil {
                    return i
                }
                node = node?.next
            }
        } else {
            for i in 0 ..< count {
                let node = getNode(idx: i)
                if (node?.compare(v2: ele, compareClosure: { () -> Bool in
                    true
                }))! {
                    return i
                }
            }
        }
        return ELEMENT_NOT_FOUND
    }
    
    // MARK: 类的成员及其他信息
    public var first: BidirectionalNode<T>?
    public var last: BidirectionalNode<T>?
    
    public init(first: BidirectionalNode<T>?, last: BidirectionalNode<T>?) {
        self.first = first
        self.last = last
    }
}


fileprivate extension LinkedList {
    func getNode(idx: Int) -> BidirectionalNode<T>? {
        rangeOfCheck(idx: idx)
        var curNode = first
        if idx < (count >> 1) {
            for _ in 0 ..< idx {
                curNode = curNode?.next!
            }
        } else {
            curNode = last
            var i = count - 1
            while i > idx {
                curNode = curNode?.pre
                i -= 1
            }
        }
        return curNode
    }
}

public extension LinkedList {
    func toString() -> String {
        var string = "count=\(count), ["
        var node = first
        for i in 0 ..< count {
            if (i != 0) {
                string.append(", ")
            }
            
            string.append("\(String(describing: node?.data))");
            
            node = node?.next;
        }
        string.append("]");
        return string
    }
}
