//
//  RedBlackTree.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/6.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class RedBlackTree<Type: Comparable>: BBSTree<Type> {
    private final var RED = false
    private final var BLACK = true

    override func fixAfterAdd(node: TreeNode<Type>?) {
        guard let node = node else {
            return
        }
        
        let parent = node.parent
        if let parent = parent {
            /// 如果父节点是黑色（非红色）直接返回
            guard isRed(node: parent) else {
                return
            }
            /// 叔父节点
            let uncle = parent.sibling()
            /// 祖父节点（染红）
            let grand = red(node: parent.parent)
            
            /// 叔父节点是红色【B树上溢】
            if isRed(node: uncle) {
                black(node: uncle)
                black(node: parent)
                /// 把祖父节点当做新添加的节点
                fixAfterAdd(node: grand)
            }
            
            /// 叔父节点不是红色（没有叔父节点时，默认的组父节点的空子节点为黑色）
            if parent.isLeftChild() { /// L
                if node.isLeftChild() { /// LL
                    black(node: parent)
                } else { /// LR
                    black(node: node)
                    rotateLeft(grand: parent)
                }
                rotateRight(grand: grand!)
            } else { /// R
                if node.isLeftChild() { /// RL
                    black(node: node)
                    rotateRight(grand: parent)
                } else { /// RR
                    black(node: parent)
                }
                rotateLeft(grand: grand!)
            }
        } else {
            /// 添加的是根节点，或者上溢到了根节点
            black(node: node)
        }
    }
    
    override func fixAfterRemove(node: TreeNode<Type>?) {
        guard let node = node else {
            return
        }
        
        /// 如果删除的是红色，或者用以取代删除的子节点为红色
        if isRed(node: node) {
            black(node: node)
            return
        }
        
        /// 删除的是黑色叶子节点【下溢】
        /// parent为nil时删除的是根节点
        guard let parent = node.parent else { return }
        
        /// 删除的是黑色叶子节点【下溢】
        /// 判断被删除的node是左还是右
        let left = parent.left == nil || node.isLeftChild()
        var sibling = left ? parent.right : parent.left
        if left { /// 被删除的节点在左边，兄弟节点在右边
            if isRed(node: sibling) { /// 兄弟节点是红色
                black(node: sibling)
                red(node: parent)
                rotateLeft(grand: parent)
                /// 更换兄弟
                sibling = parent.right
            }
            
            /// 兄弟节点必然是黑色
            if isBlack(node: sibling?.left), isBlack(node: sibling?.right) {
                /// 兄弟节点没有一个红色子节点，付节点要向下跟兄弟节点合并
                let parentIsBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                if parentIsBlack {
                    fixAfterRemove(node: parent)
                }
            } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
                // 兄弟节点的左边是黑色，兄弟要先旋转
                if isBlack(node: sibling?.right) {
                    rotateRight(grand: sibling!)
                    sibling = parent.right
                }
                color(node: sibling, color: colorOf(node: parent))
                black(node: sibling?.right)
                black(node: parent)
                rotateLeft(grand: parent)
            }
        } else { // 被删除的节点在右边，兄弟节点在左边
            if isRed(node: sibling) {
                black(node: sibling)
                red(node: parent)
                rotateRight(grand: parent)
                /// 更换兄弟
                sibling = parent.left
            }
            // 兄弟节点必然是黑色
            if isBlack(node: sibling?.left), isBlack(node: sibling?.right) {
                /// 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
                let parentIsBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                if parentIsBlack {
                    fixAfterRemove(node: parent)
                }
            } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
                // 兄弟节点的左边是黑色，兄弟要先旋转
                if isBlack(node: sibling?.left) {
                    rotateLeft(grand: sibling!)
                    sibling = parent.left
                }
                color(node: sibling, color: colorOf(node: parent))
                black(node: sibling?.left)
                black(node: parent)
                rotateRight(grand: parent)
            }
        }
    }
    
    class RBNode<T: Comparable>: TreeNode<T> {
        var color = false /// 红色
    }
}

private extension RedBlackTree {
    @discardableResult func color(node: TreeNode<Type>?, color: Bool) -> TreeNode<Type>? {
        guard let node = node else { return nil }
        (node as? RBNode<Type>)?.color = color
        return node
    }
    
    @discardableResult func red(node: TreeNode<Type>?) -> TreeNode<Type>? {
        color(node: node, color: RED)
    }
    
    @discardableResult func black(node: TreeNode<Type>?) -> TreeNode<Type>? {
        color(node: node, color: BLACK)
    }
    
    func colorOf(node: TreeNode<Type>?) -> Bool {
        /// 默认空子节点为黑色
        node == nil ? BLACK : (node as! RBNode<Type>).color
    }
    
    func isRed(node: TreeNode<Type>?) -> Bool {
        colorOf(node: node)
    }
    
    func isBlack(node: TreeNode<Type>?) -> Bool {
        colorOf(node: node)
    }
    
    func createNode(ele: Type, parent: TreeNode<Type>) -> TreeNode<Type> {
        RBNode(element: ele, parent: parent)
    }
}
