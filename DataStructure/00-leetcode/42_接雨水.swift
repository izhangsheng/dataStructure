//
//  42_接雨水.swift
//  DataStructure
//
//  Created by 张胜 on 2020/5/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation
/**
 * https://leetcode-cn.com/problems/trapping-rain-water/
 */
class _42_接雨水 {
    /**
    * 空间复杂度O(1)，时间复杂度O(n)
    */
    func trap1(_ height: [Int]) -> Int {
        var left: Int = 0, right: Int = (height.count - 1)
        var total: Int = 0
        var maxHeight: (left: Int, right: Int) = (0, 0)
        
        while left < right {
            if height[left] < height[right] {
                if height[left] > maxHeight.left {
                    maxHeight.left = height[left]
                } else {
                    total += (maxHeight.left - height[left])
                }
                left += 1
            } else {
                if height[right] > maxHeight.right {
                    maxHeight.right = height[right]
                } else {
                    total += (maxHeight.right - height[right])
                }
                right -= 1
            }
        }
        
        return total
    }
    
    func trap2(_ height: [Int]) -> Int {
        let count = height.count
        guard height.count > 2 else {
            return 0
        }

        // 每根柱子右边的最大值
        var rightArray = Array(repeating: 0, count: count)
        var curIndex = count - 2
        var rightMax = height.last!
        while curIndex >= 0 {
            rightArray[curIndex] = rightMax
            rightMax = max(rightMax, height[curIndex])
            curIndex -= 1
        }
        
        // 遍历每一根柱子，看看每一根柱子上能放多少水
        var water = 0, leftMax = 0;
        for i in 1 ..< count {
            leftMax = max(leftMax, height[i - 1])
            // 求出左边最大、右边最大中的较小者
            let minValue = min(leftMax, rightArray[i])
            let curWater = (minValue - height[i]) > 0 ? minValue - height[i] : 0
            water += curWater
        }
        
        return water
    }
}
