//
//  RadixSort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/2/24.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class RadixSort: Sort<Int> {
    override func sort() {
        var max = array[0]
        for ele in array {
            if compare(v1: max, v2: ele) {
                max = ele
            }
        } /// 查找最大值O(n)
        
        // 个位数：array[i] / 1 % 10 = 3
        // 十位数：array[i] / 10 % 10 = 9
        // 百位数：array[i] / 100 % 10 = 5
        // 千位数：array[i] / 1000 % 10 = ...
        
        var divider = 1
        while divider <= max {
            countingSort(divider: divider)
            divider *= 10
        }
    }
    
    func countingSort(divider: Int) {
        var counts = [Int](repeating: 0, count: 10)
        // 统计出每个整数出现的次数
        for e in array {
            counts[e / divider % 10] += 1
        }
        // 累加次数
        for i in 1 ..< 10 {
            counts[i] += counts[i - 1]
        }
        
        // 从后往前遍历元素
        var newArray = [Int](repeating: 0, count: array.count)
        var count = array.count - 1
        
        while count - 1 >= 0 {
            let ele = counts[array[count] - 1]
            newArray[ele / divider % 10] = array[count]
            count -= 1
        }
        
        array = newArray
    }
}
