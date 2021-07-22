//
//  Trie.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/15.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class Trie<V> {
    private var count = 0
    private var root: TrieNode<V>?
    
    private class TrieNode<V> {
        var parent: TrieNode?
        var childDic: [Character: TrieNode<V>]?
        var character: Character?
        var value: V?
        var word = false // 是否为单词的结尾（是否为一个完整的单词）
    }
    
    public func size() -> Int {
        count
    }
    
    public func isEmpty() -> Bool {
        count == 0
    }
    
    public func clear() {
        root = nil
        count = 0
    }
    
    public func contain(_ key: String) -> Bool {
        guard let node = searchNode(withKey: key) else { return false }
        return node.word
    }
    
    public func get(_ key: String) -> V? {
        searchNode(withKey: key)?.value
    }
    
    public func add(_ key: String, value: V) -> V? {
        // 创建根节点
        if root == nil {
            root = TrieNode()
        }
        
        var node = root
        for c in key {
            let emptyChildren = node?.childDic == nil
            var childNode = node?.childDic?[c]
            if childNode != nil {
                childNode = TrieNode()
                childNode?.parent = node
                childNode?.character = c
                node?.childDic = emptyChildren ? [Character: TrieNode<V>]() : node?.childDic
                node?.childDic?.updateValue(childNode!, forKey: c)
            }
            node = childNode
        }
        if node!.word {
            let oldValue = node?.value
            node?.value = value
            return oldValue
        }
        
        // 新添加单词
        node?.word = true
        node?.value = value
        count += 1
        
        return nil
    }
    
    public func remove(_ key: String) -> V? {
        // 找到最后一个节点
        let node = searchNode(withKey: key)
        // 如果不是以单词结尾不用作任何处理
        if node == nil || !node!.word { return nil }
        count -= 1
        let oldValue = node?.value
        
        // 如果还有子节点
        if node?.childDic != nil, node!.childDic!.isEmpty {
            node?.word = false
            node?.value = nil
            return oldValue
        }
        
        // 没有子节点
        var parentNode = node?.parent
        while parentNode != nil {
            parentNode?.childDic?.removeValue(forKey: parentNode!.character!)
            if parentNode!.word || !parentNode!.childDic!.isEmpty { break }
            parentNode = parentNode?.parent
        }
        
        return oldValue
    }
    
    public func start(withPrefix prefix: String) -> Bool {
        searchNode(withKey: prefix) != nil
    }
}

private extension Trie {
    private func searchNode(withKey key: String) -> TrieNode<V>? {
        guard !key.isEmpty else { return nil }
        var node = root
        for c in key {
            if node == nil || node?.childDic == nil || (node?.childDic?.isEmpty ?? true) { return nil }
            node = node?.childDic?[c]
        }
        return node
    }
}
