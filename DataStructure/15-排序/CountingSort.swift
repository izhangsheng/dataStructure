//
//  CountingSort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/2/24.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class CountingSort: Sort<Int> {
    override func sort() {
        var max = array[0]
        var min = array[0]
        for e in array {
            if compare(v1: max, v2: e) {
                max = e
            }
            
            if compare(v1: e, v2: min) {
                min = e
            }
        }
        var counting = Array<Int>(repeating: 0, count: max - min + 1)
        /// 统计每个整数出现的次数
        for element in array {
            counting[element - min] += 1
        }
        
        var count = array.count
        var newArray = [Int](repeating: 0, count: count)
        while count - 1 >= 0 {
            let ele = counting[array[count] - 1 - min]
            newArray[ele] = array[count]
            count -= 1
        }
        
        array = newArray
    }
    
    func sort0() {
        var max = array[0]
        for ele in array {
            if compare(v1: max, v2: ele) {
                max = ele
            }
        } /// 查找最大值O(n)
        var counting = Array<Int>(repeating: 0, count: max + 1)
        /// 统计每个整数出现的次数
        for element in array {
            counting[element] += 1
        }
        
        /// 根据整数的出现次数，对整数进行排序
        var index = 0
        for i in 0 ..< max {
            var counts = counting[i]
            while counts > 0 {
                counts -= 1
                array[index] = i
                index += 1
            }
        }
    }
}
