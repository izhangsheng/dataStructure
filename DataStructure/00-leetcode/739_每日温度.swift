//
//  739_每日温度.swift
//  DataStructure
//
//  Created by 张胜 on 2020/5/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation
/**
 * https://leetcode-cn.com/problems/daily-temperatures/
 */
public class _739_每日温度_ {
    public func dailyTemperatures1(_ t: [Int]) -> [Int] {
        if t.isEmpty { return Array(repeating: 0, count: t.count) }
        var result = [Int]()
        let stack = Stack<Int>()
        for i in 0 ..< t.count {
            // 这里应该要写大于，不要写大于等于
            // 利用递减栈（遇到比栈顶小的就入栈，大的就出栈，直到栈为空或者栈顶元素大于当前元素）
            while !stack.isEmpty(), t[i] > t[stack.top()!] {
                result[stack.top()!] = i - stack.top()!
                stack.pop()
            }
            // 栈里存放的是元素下标
            stack.push(ele: i)
        }
        return result;
    }
}
