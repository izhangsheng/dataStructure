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
    public func dailyTemperatures(_ t: [Int]) -> [Int]? {
        if t.isEmpty { return nil }
        var result = [Int]()
        let stack = Stack<Int>()
        for i in 0 ..< t.count {
            // 这里应该要写大于，不要写大于等于
            while !stack.isEmpty(), t[i] > t[stack.top()!] {
                result[stack.top()!] = i - stack.top()!
                stack.pop()
            }
            stack.push(ele: i)
        }
        return result;
    }
}
