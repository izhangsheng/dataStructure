//
//  AVLTree.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/2.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class AVLTree<Type: Comparable>: BinarySearchTree<Type> {
    override func afterAdd(node: TreeNode<Type>) {
        var parent: TreeNode<Type>? = node
        
        while (parent != nil) {
            if isBalance(node: parent!) {
                /// 更新高度
                updateHeight(node: parent!)
            } else {
                /// 恢复平衡
                
                /// 整棵树恢复平衡
                break
            }
            parent = parent?.parent
        }
    }
    
    func rebalance(node: TreeNode<Type>) {
        
    }
    
    private class AVLNode<Type: Comparable>: TreeNode<Type> {
        var height: UInt = 1
        
        func balanceFator() -> Int {
            let (leftHeight, rightHeight) = getLeftAndRightHeight()
            
            return Int(leftHeight - rightHeight)
        }
        
        func updateHeight() {
            let (leftHeight, rightHeight) = getLeftAndRightHeight()
            
            height = 1 + max(leftHeight, rightHeight)
        }
        
        func tallerChild() -> TreeNode<Type>? {
            let (leftHeight, rightHeight) = getLeftAndRightHeight()
            
            if leftHeight > rightHeight {
                return left
            } else if leftHeight < rightHeight {
                return right
            } else {
                return isLeftChild() ? left : right
            }
        }
        
        private func getLeftAndRightHeight() -> (UInt, UInt) {
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
}
