//
//  141_环形链表.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/18.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class CheckCircleLinkedList {
    func hasCircle(head: BidirectionalNode<Int>?) -> Bool {
        if head == nil || head?.next == nil {
            return false
        }
        var slow: BidirectionalNode? = head?.next
        var fast: BidirectionalNode? = head?.next?.next
        
        while fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow?.compare(v2: fast?.data, compareClosure: { () -> Bool in
                true
            }) ?? false {
                return true
            }
        }
        return false
    }
}
