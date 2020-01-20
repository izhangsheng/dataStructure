//
//  20_有效的括号.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/19.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class ValidateBracket {
    private static let dict = ["(": ")", "[": "]", "{": "}"]
    
    static public func isValid(_ s: String) -> Bool {
        let stack = Stack<Character>()
        for c in s {
            if dict.keys.contains(String(c)) { // 左括号
                stack.push(ele: c)
            } else { // 右括号
                if stack.isEmpty() {
                    return false
                } else {
                    guard let key = stack.pop() else { return false }
                    if String(c) != dict[String(key)] { return false }
                }
            }
        }
        return stack.isEmpty()
    }
    
    static public func isValid1(_ s: String) -> Bool {
        let stack = Stack<Character>()
        for c in s {
            if c == "(" || c == "{" || c == "[" { // 左括号
                stack.push(ele: c)
            } else { // 右括号
                if stack.isEmpty() {
                    return false
                } else {
                    guard let left = stack.pop() else { return false }
                    if left == "(", c != ")" { return false }
                    if left == "[", c != "]" { return false }
                    if left == "{", c != "}" { return false }
                }
            }
        }
        return stack.isEmpty()
    }
}
