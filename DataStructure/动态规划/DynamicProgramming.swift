//
//  LCSubString.swift
//  DataStructure
//
//  Created by 张胜 on 2020/3/2.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

/// 最长公共子序列
/// 假设 2 个序列分别是 nums1、nums2
/// i ∈ [1, nums1.length]
/// j ∈ [1, nums2.length]
/// 假设 dp(i, j) 是【nums1 前 i 个元素】与【nums2 前 j 个元素】的最长公共子序列长度
/// dp[i][0] dp[0][j]初始值都为0
public func lcs(str1: String, str2: String) -> Int {
    let cs1 = [Character](str1)
    let cs2 = [Character](str2)
    
    var dp =  [[Int]](repeating: [Int](repeating: 0, count: cs2.count + 1), count: cs1.count + 1)
    for i in 1...cs1.count {
        for j in 1...cs2.count {
            if cs1[i - 1] == cs2[j - 1] {
                dp[i][j] = dp[i - 1][j - 1] + 1
            } else {
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
            }
        }
    }
    return dp[cs1.count][cs2.count]
}

/// 最长公共子串
/// 假设dp[i][j] 是以str1[i - 1]、str2[j - 1]结尾的最长公共子串长度
/// dp[i][0] dp[0][j]初始值都为0
func lCSubstring(str1: String, str2: String) -> Int {
    let cs1 = [Character](str1)
    let cs2 = [Character](str2)
    
    var dp =  [[Int]](repeating: [Int](repeating: 0, count: cs2.count + 1), count: cs1.count + 1)
    var maxValue = 0
    for i in 1...cs1.count {
        for j in 1...cs2.count {
            if cs1[i - 1] != cs2[j - 1] {
                continue
            }
            dp[i][j] = dp[i - 1][j - 1] + 1
            maxValue = max(maxValue, dp[i][j])
        }
    }
    return maxValue
}

/// 最长上升子序列
/// 假设数组是nums， [10, 2, 2, 5, 1, 7, 18] dp(i) 是以 nums[i] 结尾的最长上升子序列的长度，i ∈ [0, nums.count]
func lengthOfLIS(_ numbers: [Int]) -> Int {
    var dp = Array(repeating: 1, count: numbers.count)
    var maxValue = 1
    for i in 0 ..< dp.count {
        for j in 0 ..< i {
            if numbers[i] < numbers[j] {
                continue
            }
            dp[i] = max(dp[i], dp[j + 1])
        }
        maxValue = max(maxValue, dp[i])
    }
    return maxValue
}

/// 最大连续子序列和
/// dp[i]是以numbers[i]结尾的和
func maxSubArray(_ numbers: [Int]) -> Int {
    if numbers.isEmpty {
        return 0
    }
    var dp = numbers[0]
    var maxValue = dp
    for i in 1 ... numbers.count - 1 {
        if dp > 0 {
            dp = dp + numbers[i]
        } else {
            dp = numbers[i]
        }
        maxValue = max(maxValue, dp)
    }
    return maxValue
}

/// 找零钱
/// 假设 dp(n) 是凑到 n 分需要的最少硬币个数
func coins(_ n: Int) -> Int {
    // 面值1，5，10，20
    guard n > 0 else {
        return -1
    }
    let dp = [Int](repeating: 0, count: n + 1)
    for i in 1 ... n {
        var minCount = dp[i - 1]
        if i >= 5 {
            minCount = min(minCount, dp[n - 5])
        }
        if i >= 1 {
            minCount = min(minCount, dp[n - 1])
        }
        if i >= 10 {
            minCount = min(minCount, dp[n - 10])
        }
        if i >= 20 {
            minCount = min(minCount, dp[n - 20])
        }
    }
    return dp[n]
}

/// 背包问题
/// dp[i][j] - 最大承重为j，有i个物品可选  dp[i][0] dp[0][j]初始值都为0
func selectGoods(_ values: [Int], _ weights: [Int], _ capacity: Int) -> Int {
    guard values.isEmpty || weights.isEmpty || capacity <= 0 else {
        return 0
    }
    
    var dp = [[Int]](repeating: [Int](repeating: 0, count: capacity), count: values.count + 1)
    for i in 1 ... values.count {
        for j in 1 ... capacity {
            if j < weights[i - 1] {
                dp[i][j] = dp[i - 1][j]
            } else {
                dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - weights[i - 1]] + values[i - 1])
            }
        }
    }
    return dp[values.count][capacity]
}
