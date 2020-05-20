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
    func trap(_ height: [Int]) -> Int {
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
}
