//
//  _数组_.swift
//  DataStructure
//
//  Created by 张胜 on 2020/5/18.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

/**
 * 给定一个包含红色、白色和蓝色，一共 n 个元素的数组，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。
 * 此题中，我们使用整数 0、 1 和 2 分别表示红色、白色和蓝色。
 * 一个只包含0、1、2的整型数组，要求对它进行【原地】排序
 * 你能想出一个仅使用常数空间的一趟扫描算法吗？
 * 空间复杂度O(1)，时间复杂度O(n)
 * 链接：https://leetcode-cn.com/problems/sort-colors
 */
public class _75_颜色分类 {
    public func classify(_ numbs: inout [Int]) {
        var left = 0
        var right = numbs.count - 1
        var cur = 0
        // 扫描元素发现0放到最左边，是2放到最后边
        if left <= right {
            let value = numbs[cur]
            if value == 0 {
                numbs.swapAt(cur, left)
                cur += 1
                left += 1
            } else if value == 1 {
                cur += 1
            } else {
                numbs.swapAt(cur, right)
                right -= 1
            }
        }
    }
}

/**
 * https://leetcode-cn.com/problems/sub-sort-lcci/
 */
public class _16_部分排序 {
    public func subSort(_ array: [Int]) -> [Int] {
        if array.isEmpty {
            return Array(repeating: -1, count: 2)
        }
        
        var max = array[0]
        // 用来记录最右的那个逆序对位置
        var rightIdx = -1
        // 从左扫描到右寻找逆序对（正序：逐渐变大）
        for i in 1 ..< array.count {
            if array[i] > max {
                max = array[i]
            } else {
                rightIdx = i
            }
        }
        
        // 有序的，不用排序
        if rightIdx == -1 {
            return Array(repeating: -1, count: 2)
        }
        
        var min = array[array.count - 1]
        var idx = array.count - 2
        // 用来记录最左的那个逆序对位置
        var leftIdx = -1
        // 从右扫描到左寻找逆序对（正序：逐渐变小）
        while idx >= 0 {
            if array[idx] < min {
                min = array[idx]
            } else {
                leftIdx = idx
                idx -= 1
            }
        }
        
        return [leftIdx, rightIdx]
    }
}

/**
 * https://leetcode-cn.com/problems/merge-sorted-array/
 */
public class _88_合并两个有序数组 {
    // 三指针操作
    public func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        // nums1 = [1,3,5,0,0,0], m = 3
        // nums2 = [2,4,6],       n = 3
        nums1 += nums2
        var i1 = m
        var i2 = n
        var cur = m + n - 1
        while i2 >= 0 {
            if i1 >= 0, nums2[i2] < nums1[i1] {
                nums1[cur] = nums2[i2]
                i2 -= 1
            } else { // i1 < 0 || nums2[i2] >= nums1[i1]
                nums1[cur] = nums2[i1]
                i1 -= 1
            }
            cur -= 1
        }
    }
}
