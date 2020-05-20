//
//  239_滑动窗口最大值.swift
//  DataStructure
//
//  Created by 张胜 on 2020/5/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

/**
 * https://leetcode-cn.com/problems/sliding-window-maximum/
 */
public class _239_滑动窗口最大值 {
    public func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.isEmpty || k < 1 { return [0] }
        if k == 1 { return nums }
        var maxes = [Int]()
        // 当前滑动窗口的最大值索引
        var maxIdx = 0
        // 求出前k个元素的最大值索引
        for i in 1 ..< k {
            if nums[i] > nums[maxIdx] { maxIdx = i }
        }
        
        // li是滑动窗口的最左索引
        let count = nums.count - k + 1
        for li in 0 ..< count {
            // ri是滑动窗口的最右索引
            let ri = li + k - 1
            if maxIdx < li { // 最大值的索引不在滑动窗口的合理范围内
                // 求出【li, ri】范围内最大值得索引
                maxIdx = li
                for i in li + 1 ... ri {
                    if nums[i] > nums[maxIdx] { maxIdx = i }
                }
            } else if nums[ri] >= nums[maxIdx] { // 最大值得索引在滑动窗口的合理范围内
                maxIdx = ri
            }
            maxes[li] = nums[maxIdx]
        }
        
        return maxes
    }
}
