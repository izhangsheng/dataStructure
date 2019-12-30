//
//  226_翻转二叉树.swift
//  DataStructure
//
//  Created by 张胜 on 2019/12/8.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class ReverseBinaryTree {
    @discardableResult public func reverseTreeByPreorder(root: TreeNode<Int>?) -> TreeNode<Int>? {
        if let node = root {
            let temNode = node.left
            let right = node.right
            node.left = right
            node.right = temNode
            reverseTreeByPreorder(root: root?.left)
            reverseTreeByPreorder(root: root?.right)
        }
        return root
    }
    //   public TreeNode invertTree(TreeNode root) {
    //       if (root == null) return root;
    //
    //       TreeNode tmp = root.left;
    //       root.left = root.right;
    //       root.right = tmp;
    //
    //       invertTree(root.left);
    //       invertTree(root.right);
    //
    //       return root;
    //   }
        
    //    public TreeNode invertTree(TreeNode root) {
    //       if (root == null) return root;
    //
    //       invertTree(root.left);
    //       invertTree(root.right);
    //
    //       TreeNode tmp = root.left;
    //       root.left = root.right;
    //       root.right = tmp;
    //
    //       return root;
    //    }
        
    //    public TreeNode invertTree(TreeNode root) {
    //       if (root == null) return root;
    //
    //       invertTree(root.left);
    //
    //       TreeNode tmp = root.left;
    //       root.left = root.right;
    //       root.right = tmp;
    //
    //       invertTree(root.left);
    //
    //       return root;
    //    }
    public func reverseTreeByLevelErgodic(root: TreeNode<Int>?) -> TreeNode<Int>? {
        if let root = root {
            var queue = [root]
            while !queue.isEmpty {
                let node = queue.removeFirst()
                let left = node.left
                let temp = left
                let right = node.right
                node.left = right
                node.right = temp
                if let left = left {
                    queue.append(left)
                }
                if let right = right {
                    queue.append(right)
                }
            }
        }
        return root
    }
//        public TreeNode invertTree(TreeNode root) {
//            if (root == null) return root;
//
//            Queue<TreeNode> queue = new LinkedList<>();
//            queue.offer(root);
//
//            while (!queue.isEmpty()) {
//                TreeNode node = queue.poll();
//                TreeNode tmp = node.left;
//                node.left = node.right;
//                node.right = tmp;
//
//                if (node.left != null) {
//                    queue.offer(node.left);
//                }
//
//                if (node.right != null) {
//                    queue.offer(node.right);
//                }
//            }
//            return root;
//        }
}
