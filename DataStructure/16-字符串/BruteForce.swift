//
//  BruteForce.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/6/30.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

class BruteForce { // 暴力匹配算法
    public static func indexOf(_ text: String, search pattern: String) -> Int {
        guard !text.isEmpty, !pattern.isEmpty else {
            return -1
        }
        
        guard pattern.count <= text.count else {
            return -1
        }
        
        let tiMax = text.count - pattern.count
        for ti in 0 ... tiMax {
            var pi = 0
            while pi < pattern.count {
                let tChar = text[text.index(text.startIndex, offsetBy: ti + pi)]
                let pChar = pattern[pattern.index(pattern.startIndex, offsetBy: pi)]
                if tChar != pChar { break }
                pi += 1
            }
            if pi == pattern.count { return ti }
        }
        return -1
    }
    
    public static func indexOf1(_ text: String, search pattern: String) -> Int {
        let tLen = text.count
        guard tLen > 0 else {
            return -1
        }
        
        let pLen = pattern.count
        guard pLen > 0 else {
            return -1
        }
        
        guard tLen >= pLen else {
            return -1
        }
        
        var pi = 0, ti = 0
        let lenDelta = tLen - pLen
        while pi < pLen, ti - pi <= lenDelta {
            let tChar = text[text.index(text.startIndex, offsetBy: ti)]
            let pChar = pattern[pattern.index(pattern.startIndex, offsetBy: pi)]
            if tChar == pChar {
                ti += 1
                pi += 1
            } else { // 匹配失败
                ti = ti - pi + 1
                pi = 0 // 重置为0
            }
        }
        
        return (pi == pLen) ? (ti - pi) : -1
    }
    
    public static func indexOf2(_ text: String, search pattern: String) -> Int {
        let tLen = text.count
        guard tLen > 0 else {
            return -1
        }
        
        let pLen = pattern.count
        guard pLen > 0 else {
            return -1
        }
        
        guard tLen >= pLen else {
            return -1
        }
        
        var pi = 0, ti = 0
        while pi < pLen, ti < tLen {
            let tChar = text[text.index(text.startIndex, offsetBy: ti)]
            let pChar = pattern[pattern.index(pattern.startIndex, offsetBy: pi)]
            if tChar == pChar {
                ti += 1
                pi += 1
            } else {
                ti = ti - pi + 1
                pi = 0
            }
        }
        
        return (pi == pLen) ? (ti - pi) : -1
    }
}
