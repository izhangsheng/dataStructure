//
//  _链表_.swift
//  DataStructure
//
//  Created by 张胜 on 2020/5/18.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation
/**
 *  https://leetcode-cn.com/problems/linked-list-cycle/
 */
public class _141_环形链表_ {
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

/**
 * https://leetcode-cn.com/problems/reverse-linked-list/
 */
public class _206_反转链表_ {
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
            newHead = cur
            cur = next
        }
        return newHead
    }
}

/**
 * https://leetcode-cn.com/problems/delete-node-in-a-linked-list/
 */
public class _237_删除链表中节点_ {
    public func deleteNode(withNode node: ListNode<Int>) {
        node.val = node.next?.val ?? 0
        node.next = node.next?.next
    }
}

/**
 * https://leetcode-cn.com/problems/palindrome-linked-list/
 */

public class _234_回文链表 {
    public func isPalindrome(_ head: ListNode<Int>?) -> Bool {
        guard let _ = head else { return true }
        guard let _ = head?.next else { return true }
        if head?.next?.next == nil {
            return head!.val == head!.next!.val
        }
        
        let reverseNode = reverse(findMidNode(head!))
        var isPalindrome = true
        var lNode = head?.next
        var rNode = reverseNode.next
        
        while let _ = rNode {
            if lNode!.val != rNode!.val {
                isPalindrome = false
                break
            }
            lNode = lNode?.next
            rNode = rNode?.next
        }
        
        return isPalindrome
    }
    
    /// 找到中间节点（右半部分链表头结点的前一个节点）
    /// 比如 1>2>3>2>1中的3是中间节点
    /// 比如 1>2>2>1中左边第一个2是中间节点
    /// - Parameter head: 头结点
    /// - Returns: head
    private func findMidNode(_ head: ListNode<Int>) -> ListNode<Int> {
        var slow = head
        var fast = head
        while let _ = fast.next, let _ = fast.next?.next {
            slow = slow.next!
            fast = fast.next!.next!
        }
        return slow
    }
    
    private func reverse(_ head: ListNode<Int>) -> ListNode<Int> {
        var newHead: ListNode<Int>? = nil
        var cur: ListNode<Int>? = head
        
        while cur != nil  {
            let tmp = cur?.next
            cur?.next = newHead
            newHead = cur
            cur = tmp
        }
        return newHead!
    }
}

/**
 * https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list-ii/
 */
public class _82_删除链表中重复元素_ {
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
