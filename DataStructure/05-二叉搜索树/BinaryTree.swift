//
//  BinaryTree.swift
//  DataStructure
//
//  Created by 张胜 on 2019/12/5.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public class TreeNode<Type: Comparable> {
    var element: Type
    var left: TreeNode<Type>?
    var right: TreeNode<Type>?
    var parent: TreeNode<Type>?
    
    init(element: Type, parent: TreeNode<Type>?) {
        self.element = element
        self.parent = parent
    }
    
    func isLeaf() -> Bool {
        (left == nil && right == nil)
    }
    
    func hasTwoChildren() -> Bool {
        (left != nil && right != nil)
    }
    
    func isLeftChild() -> Bool {
        guard let _ = parent?.left else { return false }
        return self == parent?.left
    }
    
    func isRightChild() -> Bool {
        guard let _ = parent?.right else { return false }
        return self == parent?.right
    }
    
    func sibling() -> TreeNode<Type>? {
        if isLeftChild() {
            return self.parent?.right
        } else if isRightChild() {
            return self.parent?.left
        } else {
            return nil
        }
    }
}

extension TreeNode: Comparable {
    public static func < (lhs: TreeNode<Type>, rhs: TreeNode<Type>) -> Bool {
        lhs.element < rhs.element
    }
    
    public static func == (lhs: TreeNode<Type>, rhs: TreeNode<Type>) -> Bool {
        lhs.element == rhs.element && lhs.left?.element == rhs.left?.element && lhs.right?.element == rhs.right?.element && lhs.parent?.element == rhs.parent?.element
    }
}

public class BinaryTree<Type: Comparable> {
    private var count = 0
    var root: TreeNode<Type>?
        
    init(root: TreeNode<Type>?) {
        self.root = root
    }
    
    func size() -> Int {
        count
    }

    
    func isEmpty() -> Bool {
        count == 0
    }

    func clear() {
        root = nil
        count = 0
    }
    
    
    func preorder(visitor: @escaping((Type) -> Bool)) {
        if root == nil {
            return
        }
        
        preorder(visitor: visitor, node: root)
    }
    
    // 利用栈迭代遍历
    func preorderByStack(visitor: ((Type) -> Bool)) {
        guard let root = root else {
            return
        }
        let stack = Stack<TreeNode<Type>>()
        stack.push(ele: root)
        while !stack.isEmpty() {
            let node = stack.pop()
            if visitor(node!.element) {
                return
            }
            
            /// 因为是栈结构，先把右子树入栈
            if let right = node!.right {
                stack.push(ele: right)
            }
            
            /// 左子树后入栈，再去栈顶元素时先访问左子树
            if let left = node!.left {
                stack.push(ele: left)
            }
        }
    }
    
    func inorder(visitor: @escaping((Type) -> Bool)) {
        if root == nil {
            return
        }
        inorder(visitor: visitor, node: root)
    }
    
    func inorderByStack(visitor: ((Type) -> Bool)) {
        var node = root
        let stack = Stack<TreeNode<Type>>()
        while !stack.isEmpty() || node != nil {
            if let nodeOK = node {
                stack.push(ele: nodeOK)
                node = nodeOK.left
            } else {
                node = stack.pop()
                if visitor(node!.element) {
                    return
                }
                node = node?.right
            }
        }
    }
    
    func postorder(visitor: ((Type) -> Bool)) {
        if root == nil {
            return
        }
        
        postorder(visitor: visitor, node: root)
    }
    
    func postorderByStack(visitor: ((Type) -> Bool)) {
        guard let root = root else {
            return
        }
        
        let stack1 = Stack<TreeNode<Type>>()
        let stack2 = Stack<TreeNode<Type>>()
        
        stack1.push(ele: root)
        while !stack1.isEmpty() {
            let node = stack1.pop()
            
            stack2.push(ele: node!)
            if let left = node?.left {
                stack1.push(ele: left)
            }
            if let right = node?.right {
                stack1.push(ele: right)
            }
        }
        
        while !stack2.isEmpty() {
            let node = stack2.pop()
            if visitor(node!.element) {
                return
            }
        }
    }
    
    func levelOrder(visitor: @escaping((Type) -> Bool)) {
        if root == nil { return }
        var queue = [root]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if visitor(node!.element) { return }
            
            if let left = node?.left {
                queue.append(left)
            }
            
            if let right = node?.right {
                queue.append(right)
            }
        }
    }
    
    func isComplete() -> Bool {
        if root == nil { return false }
        var queue = [root]
        
        var leaf = false
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if leaf, !node!.isLeaf() { return false }
            
            if let left = node?.left {
                queue.append(left)
            } else if let _ = node?.right {
                return false
            }
            
            if let right = node?.right {
                queue.append(right)
            } else {
                leaf = true
            }
        }
        return leaf
    }
    
    
    func height() -> UInt {
        guard let root = root else { return 0 }
        
        // 树的高度
        var height: UInt = 0
        // 存储着每一层的元素数量
        var levelSize = 1
        var queue = [root]
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            levelSize -= 1
            
            if let left = node.left {
                queue.append(left)
            }
            
            if let right = node.right {
                queue.append(right)
            }
            
            if levelSize == 0 { // 意味着即将要访问下一层
                levelSize = queue.count
                height += 1
            }
        }
        
        return height
    }
    
    func height2() -> UInt {
        return height(node: root)
    }
    
    
    
    private func height(node: TreeNode<Type>?) -> UInt {
        guard let node = node else {
            return 0
        }
        let leftH = height(node: node.left)
        let rightH = height(node: node.right)
        return 1 + max(leftH, rightH)
    }

    func predecessor(node: TreeNode<Type>?) -> TreeNode<Type>? {
        guard let node = node else {
            return nil
        }
        
        // 前驱节点在左子树当中（left.right.right.right....）
        let left = node.left
        if let left = left {
            var right = left.right
            while right != nil {
                right = right?.right
            }
            return right
        }
        
        // （如果左边为空）从父节点、祖父节点中寻找前驱节点
        
        var parentNode = node.parent
        var newNode: TreeNode<Type>? = node
        while parentNode != nil, parentNode?.right?.element != newNode?.element {
            newNode = parentNode
            parentNode = newNode?.parent
        }
        return parentNode
    }
    
    func successor(node: TreeNode<Type>?) -> TreeNode<Type>? {
        guard let node = node else {
            return nil
        }
        
        // 后继节点在左子树当中（right.left.left.left....）
        let right = node.right
        if right != nil {
            var left = right?.left
            while left != nil {
                left = left?.left
            }
            return left
        }
        
        // 从父节点、祖父节点中寻找前驱节点
        var parent = node.parent
        var newNode: TreeNode<Type>? = node
        while parent != nil, newNode?.element != parent?.left?.element {
            newNode = parent
            parent = parent?.parent
        }

        return parent
    }
}

private extension BinaryTree {
    func preorder(visitor: ((Type) -> Bool), node: TreeNode<Type>?) {
        guard let nodeOK = node else { return }
        /// 利用访问器访问节点
        if visitor(nodeOK.element) { return }
        preorder(visitor: visitor, node: nodeOK.left)
        preorder(visitor: visitor, node: nodeOK.right)
    }
    
    func inorder(visitor: ((Type) -> Bool), node: TreeNode<Type>?) {
        guard let nodeOK = node else { return }
        inorder(visitor: visitor, node: nodeOK.left)
        /// 利用访问器访问节点
        if visitor(nodeOK.element) { return }
        preorder(visitor: visitor, node: nodeOK.right)
    }
    
    func postorder(visitor: ((Type) -> Bool), node: TreeNode<Type>?) {
        guard let nodeOK = node else { return }
        postorder(visitor: visitor, node: nodeOK.left)
        postorder(visitor: visitor, node: nodeOK.right)
        /// 利用访问器访问节点
        if visitor(nodeOK.element) { return }
    }
}
