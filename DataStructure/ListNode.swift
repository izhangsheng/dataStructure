//
//  ListNode.swift
//  DataStructure
//
//  Created by 张胜 on 2019/10/29.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func reverseList(head: ListNode?) -> ListNode? {
    guard let _ = head else {
        return head
    }
    guard let _ = head?.next else {
        return head
    }
    var newNode: ListNode? = nil
    var curNode = head
    
    while var _ = curNode {
        let tmpNode = head?.next
        tmpNode?.next = newNode
        newNode = head
        curNode = tmpNode
    }
    return newNode
}

class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard var headNode = head else {
            return nil
        }
        let list = ListNode.init(headNode.val)
        var newHead = list
        while let next = headNode.next {
            let newNode = ListNode.init(next.val)
            newNode.next = newHead
            newHead = newNode
            headNode = next
        }
        return newHead
    }
}
