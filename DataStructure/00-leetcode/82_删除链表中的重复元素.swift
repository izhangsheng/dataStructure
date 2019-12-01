//
//  82_删除链表中的重复元素.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/25.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

func deleteDuplicates(head: ListNode?) -> ListNode? {
    guard head != nil, head?.next != nil else {
        return head
    }
    /// 虚拟头节点
    let fakeHead: ListNode? = ListNode(0)
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
