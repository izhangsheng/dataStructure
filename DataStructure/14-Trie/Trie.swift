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
        var childDic: [Character: V]?
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
    }
    
    public func get(_ key: String) -> V? {
        nil
    }
}

private extension Trie {
    private func node(_ key: String) -> TrieNode<V>? {
        guard !key.isEmpty else { return nil }
        return nil
    }
}
