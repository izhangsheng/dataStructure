//
//  BinarySearchTree.swift
//  DataStructure
//
//  Created by 张胜 on 2019/12/8.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class BinarySearchTree<E: Comparable>: BinaryTree<E> {
    public func add(ele: E) {
        elementNotNullCheck(ele: ele)
        // 添加第一个节点
        if root == nil {
            root = TreeNode(element: ele, parent: nil)
            count += 1
            return
        }
        
        // 添加的不是第一个节点
        // 找到父节点
        var parent = root;
        var curNode = root;
        var isParentLeft = false
        while curNode != nil {
            parent = curNode
            if ele > curNode!.element {
                curNode = curNode?.right
            } else if ele < curNode!.element {
                isParentLeft = true
                curNode = curNode?.left
            } else {
                curNode?.element = ele
                return
            }
        }
        // 看看插入到父节点的哪个位置
        let newNode = TreeNode(element: ele, parent: parent)
        if isParentLeft {
            parent?.left = newNode
        } else {
            parent?.right = newNode
        }
        count += 1
    }

    public func remove(ele: E) {
        remove(node: node(ele: ele))
    }

    public func contains(ele: E) -> Bool {
        return node(ele: ele) != nil
    }
    
}

fileprivate extension BinarySearchTree {
    func elementNotNullCheck(ele: E?) {
        if ele == nil {
            fatalError("element must not be null")
        }
    }
    
    func node(ele: E) -> TreeNode<E>? {
        var node = root
        
        while node != nil {
            if ele == node!.element { return node }
            if ele > node!.element {
                node = node?.right
            } else {
                node = node?.left
            }
        }
        return nil
    }
    
    func remove(node: TreeNode<E>?) {
        guard var node = node else {
            return
        }
        count -= 1
        if node.hasTwoChildren() {
            // 度为2的节点肯定又后继
            // 找到后继
            let s = successor(node: node)
            // （度为2的节点肯定有后继）用后继节点的值覆盖度为2的节点的值
            node.element = s!.element
            // 删除后继节点
            node = s!
        }
        
        // 删除node节点（node的度必然是1或者0）
        let replacementNode = node.left != nil ? node.left : node.right
        if replacementNode != nil { // node是度为1的节点
            // 更改parent
            replacementNode?.parent = node.parent
            // 更改parent的left、right的指向
            if node.parent == nil { // node是度为1的节点且是根节点
                root = replacementNode
            } else if node === node.parent?.left {
                node.parent?.left = replacementNode
            } else { // node = node.parent.right
                node.parent?.right = replacementNode
            }
        } else if node.parent == nil { // node是叶子节点且是跟节点
            root = nil
        } else { // node是叶子节点，但不是根节点
            if node === node.parent?.left {
                node.parent?.left = nil
            } else { // node = node.parent.right
                node.parent?.right = nil
            }
        }
    }
}

