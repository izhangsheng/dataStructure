//
//  237_删除链表中的节点.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/18.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public class DeleteNodeForLinkedlist {
    public func deleteNode(withNode node: ListNode<Int>) {
        node.next = node.next?.next
        node.val = node.next?.next?.val ?? 0
    }
}
