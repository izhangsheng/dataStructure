//
//  82_删除链表中的重复元素.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/25.
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

public class DeleteDuplicateForLinkedList {
    func deleteDuplicates(head: ListNode<Int>?) -> ListNode<Int>? {
        guard head != nil, head?.next != nil else {
            return head
        }
        /// 虚拟头节点
        let fakeHead: ListNode? = ListNode<Int>(0)
        fakeHead?.next = head

        var prevNode = fakeHead
        var slow = prevNode?.next
        var fast = slow?.next

        while slow != nil, fast != nil {
            var hasMatchOnce = false
            while slow != nil, fast != nil, slow!.val == fast!.val {
                // 往后顺延
                fast = fast?.next
                hasMatchOnce = true
            }

            if hasMatchOnce {
                prevNode?.next = fast
            } else {
                prevNode = slow
            }
            
            slow = fast
            fast = fast?.next
        }

        return fakeHead?.next
    }
}

