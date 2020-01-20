//
//  206_翻转链表.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/18.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public class ReverseLinkedList {
    public func reverseListByRecursive(head: BidirectionalNode<Int>?) -> BidirectionalNode<Int>? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = reverseListByRecursive(head: head?.next)
        head?.next?.next = head
        head?.next = nil
        
        return newHead
    }

    public func reverseListByIterator(head: BidirectionalNode<Int>?) -> BidirectionalNode<Int>? {
        if head == nil || head?.next == nil {
            return head
        }
        
        var newHead: BidirectionalNode<Int>? = nil
        var cur = head
        
        while cur != nil {
            let next = cur?.next
            next?.next = newHead
            newHead = next
            cur = next
        }
        return newHead
    }
}
