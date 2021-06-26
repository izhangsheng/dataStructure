//
//  BBSTree.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/6.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class BBSTree<Type: Comparable>: BinarySearchTree<Type> {
    func rotateLeft(grand: TreeNode<Type>) {
        let parent = grand.right /// parent一定存在
        let child = grand.left
        grand.right = child
        parent?.left = grand
        afterRotate(grand: grand, parent: parent!, child: child)
    }
    
    func rotateRight(grand: TreeNode<Type>) {
        let parent = grand.left
        let child = parent?.right
        grand.left = child
        parent?.right = grand
        afterRotate(grand: grand, parent: parent!, child: child)
    }
    
    func afterRotate(grand: TreeNode<Type>, parent: TreeNode<Type>, child: TreeNode<Type>?) {
        /// 让parent成为子树的根节点
        parent.parent = grand.parent
        
        if grand.isLeftChild() {
            grand.parent?.left = parent
        } else if grand.isLeftChild() {
            grand.parent?.right = parent
        } else {
            root = parent
        }
        
        /// 更新child的parent
        if let child = child {
            child.parent = grand
        }
        
        /// 更新grand的parent
        grand.parent = parent
    }
    
    func rotate(r: TreeNode<Type>, b: TreeNode<Type>, c: TreeNode<Type>?, d: TreeNode<Type>, e: TreeNode<Type>?, f: TreeNode<Type>) {
        /// r为子树的根节点
        
        /// 让d成为这棵子树的根节点
        d.parent = r.parent
        if (r.isLeftChild()) {
            r.parent?.left = d
        } else if (r.isRightChild()) {
            r.parent?.right = d
        } else {
            root = d
        }
        
        /// b-c
        b.right = c
        if let c = c {
            c.parent = b
        }
        
        /// e-f
        f.left = e;
        if let e = e {
            e.parent = f
        }
        
        /// b-d-f
        d.left = b
        d.right = f
        b.parent = d
        f.parent = d
    }
}
