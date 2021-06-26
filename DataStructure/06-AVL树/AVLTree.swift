//
//  AVLTree.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/2.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class AVLTree<Type: Comparable>: BBSTree<Type> {
    override func fixAfterAdd(node: TreeNode<Type>?) {
        var parent: TreeNode<Type>? = node
        
        while (parent != nil) {
            if isBalance(node: parent!) {
                /// 更新高度
                updateHeight(node: parent!)
            } else {
                /// 恢复平衡
                rebalance(grand: parent!)
                /// 整棵树恢复平衡
                break
            }
            parent = parent?.parent
        }
    }
    
    override func fixAfterRemove(node: TreeNode<Type>?) {
        var parent: TreeNode<Type>? = node
        
        while (parent != nil) {
            if isBalance(node: parent!) {
                /// 更新高度
                updateHeight(node: parent!)
            } else {
                /// 恢复平衡
                rebalance(grand: parent!)
                /// 整棵树恢复平衡
                break
            }
            parent = parent?.parent
        }
    }
    
    override internal func afterRotate(grand: TreeNode<Type>, parent: TreeNode<Type>, child: TreeNode<Type>?) {
        super.afterRotate(grand: grand, parent: parent, child: child)
        
        /// 更新高度
        updateHeight(node: grand)
        updateHeight(node: parent)
    }
    
    override internal func rotate(r: TreeNode<Type>, b: TreeNode<Type>, c: TreeNode<Type>?, d: TreeNode<Type>, e: TreeNode<Type>?, f: TreeNode<Type>) {
        super.rotate(r: r, b: b, c: c, d: d, e: e, f: f)
        
        /// 更新高度
        updateHeight(node: b)
        updateHeight(node: d)
        updateHeight(node: f)
    }
    
    class AVLNode<Type: Comparable>: TreeNode<Type> {
        var height: UInt = 1
        
        func balanceFator() -> Int {
            let (leftHeight, rightHeight) = getLeftAndRightHeight()
            
            return Int(leftHeight - rightHeight)
        }
        
        func updateHeight() {
            let (leftHeight, rightHeight) = getLeftAndRightHeight()
            
            height = 1 + max(leftHeight, rightHeight)
        }
        
        
        /// 在恢复平衡时，一定有最高的子节点
        func tallerChild() -> TreeNode<Type> {
            let (leftHeight, rightHeight) = getLeftAndRightHeight()
            
            if leftHeight > rightHeight {
                return left!
            } else if leftHeight < rightHeight {
                return right!
            } else {
                return isLeftChild() ? left! : right!
            }
        }
        
        func getLeftAndRightHeight() -> (UInt, UInt) {
            var leftHeight: UInt = 0
            if let left = left as? AVLNode {
                leftHeight = left.height
            }
            
            var rightHeight: UInt = 0
            if let right = right as? AVLNode {
                rightHeight = right.height
            }
            return (leftHeight, rightHeight)
        }
    }
}

fileprivate extension AVLTree {
    func isBalance(node: TreeNode<Type>) -> Bool {
        guard let node = node as? AVLNode else { return false }
        return abs(node.balanceFator()) <= 1
    }
    
    func updateHeight(node: TreeNode<Type>) {
        guard let node = node as? AVLNode else { return }
        node.updateHeight()
    }
    
    /// 恢复平衡
    /// - Parameter grand: 高度最低的那个不平衡节点
    func rebalance(grand: TreeNode<Type>) {
        let parent = (grand as! AVLNode<Type>).tallerChild();
        let node = (parent as! AVLNode<Type>).tallerChild();
        if (parent.isLeftChild()) { // L
            if (node.isLeftChild()) { // LL
                rotateRight(grand: grand)
            } else { // LR
                rotateLeft(grand: parent)
                rotateRight(grand: grand)
            }
        } else { // R
            if (node.isLeftChild()) { // RL
                rotateRight(grand: parent)
                rotateLeft(grand: grand)
            } else { // RR
                rotateLeft(grand: grand);
            }
        }
    }
    
    /// 恢复平衡
    /// - Parameter grand: 高度最低的那个不平衡节点
    func rebalance2(grand: TreeNode<Type>) {
        let parent = (grand as? AVLNode)?.tallerChild();
        let node = (grand as? AVLNode)?.tallerChild();
        if (parent?.isLeftChild() ?? false) { // L
            if (node?.isLeftChild() ?? false) { // LL
                rotate(r: grand, b: node!, c: node?.right, d: parent!, e: parent?.right, f: grand)
            } else { // LR
                rotate(r: grand, b: parent!, c: node?.left, d: node!, e: node?.right, f: grand)
            }
        } else { // R
            if (node?.isLeftChild() ?? false) { // RL
                rotate(r: grand, b: grand, c: node?.left, d: node!, e: node?.right, f: parent!)
            } else { // RR
                rotate(r: grand, b: grand, c: node?.left, d: parent!, e: node?.left, f: node!)
            }
        }
    }
}
