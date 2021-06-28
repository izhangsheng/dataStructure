//
//  HashMap.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/14.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

private let DEFAULT_CAPACITY = 1 << 4;
private let DEFAULT_LOAD_FACTOR = 0.75

class HashMap<K, V> where K: Hashable, V: Equatable {
    private var count = 0
    private var table: [Node?] = Array(repeating: nil, count: DEFAULT_CAPACITY)
    
    private class Node {
        var hashCode: Int = 0
        var key: K
        var value: V
        var next: Node?
        init(key: K, value: V, next: Node?) {
            self.key = key
            self.value = value
            self.next = next
            hashCode = (key.hashValue ^ (key.hashValue >> 16))
        }
    }
    
    // MARK: private
    private func index(key: Key) -> Int {
        return hashCode(key: key) & (table.count - 1)
    }
    
    private func hashCode(key: Key) -> Int {
        let hash = key.hashValue
        return hash ^ (hash >> 16)
    }
    
    private func getNode(key: K) -> Node? {
        let head = table[index(key: key)]
        return searchNode(head: head, key: key)
    }
    
    private func searchNode(head: Node?, key: K) -> Node? {
        guard let headNode = head else {
            return nil
        }
        if key == headNode.key {
            return headNode
        }
        // hash冲突，迭代寻找
        var curNode: Node? = headNode.next
        while curNode != nil {
            if curNode?.key == key {
                return curNode
            }
            curNode = curNode?.next
        }
        return nil
    }
    
    /// 扩容操作（核心）
    private func resize() {
        if Double(count / DEFAULT_CAPACITY) < DEFAULT_LOAD_FACTOR {
            return
        }
        // 扩容
        let oldTable = table
        // 这里扩容为原来的2倍
        let oldCapcity = oldTable.count
        let newCapacity = oldCapcity << 1
        table = Array(repeating: nil, count: newCapacity)
        
        for i in 0 ..< oldCapcity {
            let head = oldTable[i]
            if head == nil {
                continue
            }
            
            if head?.next == nil {
                let idx = index(key: head!.key)
                table[idx] = head
            } else { // 冲突，链表上的元素重放，新的索引要么不变要么为旧的容量加上旧的索引
                // 低位
                var loHead: Node? = nil, loTail: Node? = nil
                // 高位
                var hiHead: Node? = nil, hiTail: Node? = nil
                
                var next: Node? = nil
                var current = head
                repeat {
                    next = current?.next
                    if oldCapcity & next!.hashCode == 0 { // 在扩容下计算出的索引值不变
                        if loTail == nil { // 未取得头结点
                            loHead = current
                        } else {
                            loTail?.next = current
                        }
                        loTail = current // 第一次赋值head == tail == current
                    } else { // 在扩容下计算出的索引值为旧的容量+旧的索引值
                        if hiTail == nil { // 未取得头结点
                            hiHead = current
                        } else {
                            hiTail?.next = current
                        }
                        hiTail = current
                    }
                    current = next
                } while next != nil
                
                if let _ = hiTail {
                    hiTail?.next = nil
                    table[oldCapcity + i] = hiHead
                }
                
                if let _ = loTail {
                    loTail?.next = nil
                    table[i] = loHead
                }
            }
        }
    }
}

extension HashMap: MapProtocal {
    typealias Key = K
    
    typealias Value = V
    
    func set(forKey k: K, value v: V) -> V? {
        resize()
        let old = getNode(key: k)
        if let oldExist = old {
            let oldValue = oldExist.value
            oldExist.value = v
            return oldValue
        } else {
            table[index(key: k)] = Node(key: k, value: v, next: nil)
        }
        
        return nil
    }
    
    func get(forKey k: K) -> V? {
        return getNode(key: k)?.value
    }
    
    func size() -> Int {
        return count
    }
    
    func allKeys() -> [K] {
        var keys = [K]()
        traversal { (key, value) -> Bool in
            keys.append(key)
            return false
        }
        
        return keys
    }
    
    func allValues() -> [V] {
        var values = [V]()
        traversal { (key, value) -> Bool in
            values.append(value)
            return false
        }
        
        return values
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func remove(forKey k: K) -> V? {
        let idx = index(key: k)
        let head: Node? = table[idx]
     
        if let headNode = head {
            if headNode.key == k {
                table[idx] = nil
                return headNode.value
            }
            var preNode: Node? = headNode
            var curNode: Node? = headNode.next
            while curNode != nil {
                if curNode?.key == k {
                    preNode?.next = curNode?.next
                    return curNode?.value
                }
                preNode = curNode
                curNode = curNode?.next
            }
        }
        return nil
    }
    
    func containKey(key: K) -> Bool {
        allKeys().contains(key)
    }
    
    func containValue(value: V) -> Bool {
        allValues().contains(value)
    }
    
    func traversal(visitor: @escaping ((K, V) -> Bool)) {
        for i in 0 ..< table.count {
            let head = table[i]
            if let headNode = head {
                var curNode: Node? = headNode
                while curNode != nil {
                    if visitor(curNode!.key, curNode!.value) { return }
                    curNode = curNode?.next
                }
            }
        }
    }
    
    func clear() {
        guard count > 0 else {
            return
        }
        count = 0
        table.removeAll()
    }
}
