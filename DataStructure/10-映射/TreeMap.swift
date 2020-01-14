//
//  TreeMap.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/13.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

private let RED = false
private let BLACK = true

public class TreeMap<K: Comparable, V: Comparable>: MapProtocal {
    // MARK: MapProtocal关联类型
    public typealias Key = K
    public typealias Value = V
    
    // MARK: 私有成员
    private var count = 0
    private var root: MapNode<Key, Value>? = nil
    
    // MARK: 私有节点类
    fileprivate class MapNode<K: Comparable, V: Comparable>: Comparable {
        var key: K
        var value: V
        var left: MapNode<K, V>?
        var right: MapNode<K, V>?
        var parent: MapNode<K, V>?
        var color: Bool = RED
        init(key: K, value: V) {
            self.key = key
            self.value = value
        }
        
        // MARK: comparable
        static func < (lhs: MapNode<K, V>, rhs: MapNode<K, V>) -> Bool {
            lhs.key < rhs.key
        }
        
        static func == (lhs: MapNode<K, V>, rhs: MapNode<K, V>) -> Bool {
            lhs.key == rhs.key
        }
        
        // MARK: public interface
        func sibling() -> MapNode<K, V>? {
            if isLeftChild() {
                return self.parent?.right
            } else if isRightChild() {
                return self.parent?.left
            } else {
                return nil
            }
        }
        
        func isLeftChild() -> Bool {
            guard let _ = left else { return false }
            return true
        }
        
        func isRightChild() -> Bool {
            guard let _ = right else { return false }
            return true
        }
        
        func hasTwoChild() -> Bool {
            left != nil && right != nil
        }
    }
    
    // MARK: MapProtocal
    public func set(forKey k: K, value v: V) -> Value? {
        if root == nil {
            root = MapNode(key: k, value: v)
            count += 1
            
            // 添加之后红黑树修复
            afterSet(mapNode: root!)
            return nil
        }
        
        // 添加的不是第一个节点
        var node = root
        var isLeft = false
        while node != nil {
            if k > node!.key {
                node = node?.right
            } else if k < node!.key {
                node = node?.left
                isLeft = true
            } else {
                node?.key = k
                let oldValue = node?.value
                node?.value = v
                return oldValue
            }
        }
        // 找到父节点
        let parent = node
        
        // 看看插入到父节点的哪个位置
        let newNode = MapNode(key: k, value: v)
        if isLeft {
            parent?.left = newNode
        } else {
            parent?.right = newNode
        }
        count += 1
        afterSet(mapNode: newNode)
        return nil
    }
    
    public func get(forKey k: K) -> V? {
        searchNode(withKey: k)?.value
    }
    
    public func clear() -> Void {
        count = 0
        root = nil
    }
    
    public func size() -> Int {
        count
    }
    
    public func allKeys() -> [K] {
        return allNodes().map { (mapNode) -> K in
            mapNode.key
        }
    }
    
    public func allValues() -> [V] {
        return allNodes().map { (mapNode) -> V in
            mapNode.value
        }
    }
    
    public func isEmpty() -> Bool {
        count == 0
    }
    
    public func remove(forKey k: K) -> V? {
        remove(withNode: searchNode(withKey: k))
    }
    
    public func containKey(key: K) -> Bool {
        searchNode(withKey: key) != nil
    }
    
    public func containValue(value: V) -> Bool {
        allValues().contains(value)
    }
    
    public func traversal(visitor: @escaping ((K, V) -> Bool)) {
        traveral(node: root, visitor: visitor)
    }
}

private extension TreeMap {
    /// 查找节点
    /// - Parameter key: 需要查找的key
    func searchNode(withKey key: Key) -> MapNode<Key, Value>? {
        var curNode = root
        while curNode != nil {
            if key > curNode!.key {
                curNode = curNode?.right
            } else if key < curNode!.key {
                curNode = curNode?.left
            } else {
                return curNode
            }
        }
        return nil
    }
    
    /// 获得所有的节点
    func allNodes() -> [MapNode<Key, Value>] {
        var nodes = [MapNode<Key, Value>]()
        levelOrder{ (mapNode) -> Bool in
            nodes.append(mapNode)
            return false
        }
        return nodes
    }
    
    /// 层序遍历
    /// - Parameter visitor: 遍历器
    func levelOrder(visitor: ((MapNode<Key, Value>) -> Bool)) {
        guard let root = root else { return }
        
        let queue = Queue<MapNode<Key, Value>>()
        queue.enQueue(ele: root)
        
        while !queue.isEmpty() {
            let node = queue.deQueue()
            if visitor(node!) {
                return
            }
            if let left = node?.left {
                queue.enQueue(ele: left)
            }
            if let right = node?.right {
                queue.enQueue(ele: right)
            }
        }
    }
    
    /// 添加新的键值对后的修复
    /// - Parameter mapNode: 待添加节点
    func afterSet(mapNode: MapNode<K, V>) {
        let parent = mapNode.parent
        if parent == nil {
            /// 添加的是根节点，或者上溢到了根节点
            black(node: mapNode)
            return
        }
        
        /// 父节点是黑色直接返回
        if isBlack(node: mapNode) { return }
        
        // 叔父节点
        let uncle = parent?.sibling()
        // 祖父节点
        let grand = parent?.parent
        if isRed(node: uncle) {
            // 叔父节点是红色 【 B树上溢 】
            black(node: parent)
            black(node: uncle)
            /// 把祖父节点当成新添加的节点进行上溢
            afterSet(mapNode: grand!)
            return
        }
        
        // 叔父节点不是红色
        if parent!.isLeftChild() {
            if mapNode.isLeftChild() { // LL进行右旋转
                black(node: parent)
            } else { // LR先左旋转parent再右旋转grand
                black(node: mapNode)
                rotateLeft(grand: parent!)
            }
            rotateLeft(grand: grand!)
        } else {
            if mapNode.isLeftChild() { // RL先右旋转再左旋转
                black(node: mapNode)
                rotateRight(grand: parent!)
            } else { // RR进行左旋转
                black(node: parent)
            }
            rotateLeft(grand: grand!)
        }
    }
    
    /// 左旋转
    /// - Parameter grand: 节点
    func rotateLeft(grand: MapNode<Key, Value>) {
        let parent = grand.right
        let child = parent?.left
        grand.right = child
        parent?.left = grand
        afterRorate(grand: grand, parent: parent!, child: child)
    }
    
    /// 右旋转
    /// - Parameter grand: 节点
    func rotateRight(grand: MapNode<Key, Value>) {
        let parent = grand.left
        let child = parent?.right
        grand.left = child
        parent?.right = grand
        afterRorate(grand: grand, parent: parent!, child: child)
    }
    
    /// 旋转之后的操作
    /// - Parameters:
    ///   - grand: 祖父节点
    ///   - parent: 父节点
    ///   - child: 子节点
    func afterRorate(grand: MapNode<Key, Value>, parent: MapNode<Key, Value>, child: MapNode<Key, Value>?) {
        // 让parent成为数的跟几点
        parent.parent = grand.parent
        if grand.isLeftChild() {
            grand.parent?.left = parent
        } else if grand.isRightChild() {
            grand.parent?.right = parent
        } else {
            root = parent
        }
        
        // 更新child
        if let child = child {
            child.parent = grand
        }
        
        // 更新grand的parent
        grand.parent = parent
    }
    
    @discardableResult func color(node: MapNode<K, V>?, color: Bool) -> MapNode<K, V>? {
        guard let node = node else { return nil }
        node.color = color
        return node
    }
    
    @discardableResult func red(node: MapNode<K, V>?) -> MapNode<K, V>? {
        color(node: node, color: RED)
    }
    
    @discardableResult func black(node: MapNode<K, V>?) -> MapNode<K, V>? {
        color(node: node, color: BLACK)
    }
    
    /// 获得节点颜色
    /// - Parameter node: 节点
    func colorOf(node: MapNode<K, V>?) -> Bool {
        /// 默认空子节点为黑色
        node == nil ? BLACK : node!.color
    }
    
    func isRed(node: MapNode<K, V>?) -> Bool {
        colorOf(node: node)
    }
    
    func isBlack(node: MapNode<K, V>?) -> Bool {
        colorOf(node: node)
    }
    
    /// 删除节点
    /// - Parameter node: 节点
    func remove(withNode node: MapNode<Key, Value>?) -> Value? {
        guard var node = node else { return nil }
        
        count -= 1
        let oldValue = node.value
        if node.hasTwoChild() { // 度为2
            // 找到后继节点
            let s = successor(node: node)
            // 用后继节点的值覆盖掉度为2节点的值
            node.key = s!.key
            node.value = s!.value
            // 删除后继节点
            node = s!
        }
        // 删除node（此时的node可能为要删除的后继节点）节点（node节点的度必然是1或者0）
        let replacement = node.left ?? node.right
        if replacement != nil {
            // 更改parent
            replacement?.parent = node.parent
            // 更改parent的left、right指向
            if node.parent == nil { // node是度为1的节点并且是根节点
                root = replacement
            } else if node == node.parent!.left {
                node.parent?.left = replacement
            } else if node == node.parent!.right {
                node.parent?.right = replacement
            }
            
            // 删除节点之后红黑树性质修复
            afterRemove(node: replacement)
        } else if node.parent == nil { // node是叶子节点并且是根节点
            root = nil
        } else { // node是叶子节点，但不是根节点
            if node == node.parent?.left {
                node.parent?.left = nil
            } else { // node == node.parent.right
                node.parent?.right = nil
            }
            
            // 删除节点之后红黑树性质修复
            afterRemove(node: replacement)
        }
        
        return oldValue
    }
    
    /// 删除节点后的红黑树修复
    /// - Parameter node: 节点
    func afterRemove(node: MapNode<Key, Value>?) {
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
                    afterRemove(node: parent)
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
                    afterRemove(node: parent)
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
    
    
    /// 查找后继节点
    /// - Parameter node: 节点
    func predecessor(node: MapNode<Key, Value>?) -> MapNode<Key, Value>? {
        guard let node = node else { return nil }
        var p = node.right
        if p != nil {
            while p?.left != nil {
                p = p?.left
            }
            return p
        }
        
        var curNode: MapNode<Key, Value>?  = node
        while curNode?.parent != nil && curNode == curNode?.parent?.left {
            curNode = curNode?.parent
        }
        return curNode
    }
    
    /// 查找前驱节点
    /// - Parameter node: 节点
    func successor(node: MapNode<Key, Value>?) -> MapNode<Key, Value>? {
        guard let node = node else { return nil }
        
        var p = node.left
        if p != nil {
            while p?.left != nil {
                p = p?.left
            }
            return p
        }
        
        var curNode: MapNode<Key, Value>? = node
        while curNode != nil && curNode == curNode?.parent?.right {
            curNode = curNode?.parent
        }
        return curNode
    }
    
    /// 递归方式进行中序遍历
    /// - Parameters:
    ///   - node: 节点
    ///   - visitor: 访问器
    func traveral(node: MapNode<Key, Value>?, visitor: ((K, V) -> Bool)) {
        guard let node = node else { return }
        traveral(node: node.left, visitor: visitor)
        if visitor(node.key, node.value) { return }
        traveral(node: node.right, visitor: visitor)
    }
}
