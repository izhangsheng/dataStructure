//
//  KMP.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/6/28.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

class KMP {
    public static func indexOf(_ text: String, search pattern: String) -> Int {
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
        
        let next = next(pattern: pattern)
        var pi = 0, ti = 0
        let lenDelta = tLen - pLen
        while pi < pLen, ti - pi <= lenDelta {
            let tChar = text[text.index(text.startIndex, offsetBy: ti)]
            let pChar = pattern[pattern.index(pattern.startIndex, offsetBy: pi)]
            
            if pi < 0 || tChar == pChar {
                ti += 1
                pi += 1
            } else {
                pi = next[pi]
            }
        }
        
        return (pi == pLen) ? (ti - pi) : -1
    }
    
    // next 数组存的最长公共前后缀中，前缀的结尾字符下标（公共前后缀长度减一）
    private static func next(pattern: String) -> [Int] {
        let chars = Array(pattern)
        var next = Array(repeating: 0, count: chars.count)
        next[0] = -1
        var k = -1
        let iMax = chars.count - 1
        for i in 1 ..< iMax {
            // 我们此时知道了 [0, i-1]的最长前后缀，但是k+1的指向的值和i不相同时，我们则需要回溯
            // 因为 next[k]就时用来记录子串的最长公共前后缀的尾坐标（即长度）
            // 就要找k+1前一个元素在next数组里的值,即next[k+1]
            while k != -1 && chars[k + 1] != chars[i] {
                k = next[k];
            }
            // 相同情况，就是 k的下一位，和 i 相同时，此时我们已经知道 [0, i-1]的最长前后缀
            // 然后 k - 1 又和 i 相同，最长前后缀加1，即可
            if chars[k+1] == chars[i] {
                k += 1
            }
            next[i] = k
        }
        
        return next
    }
}
