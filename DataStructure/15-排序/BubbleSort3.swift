//
//  BubbleSort3.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class BubbleSort3<T: Comparable>: Sort<T> {
    override func sort() {
        var end = array.count - 1

        while end > 0 {
            // 记录begin的位置
            var sortedIndex = 0
            // 是否为有序
            var isSorted = true
            
            for i in 0 ..< end {
                if compare(i1: i + 1, i2: i) {
                    swap(i1: i, i2: i + 1)
                    isSorted = false
                    sortedIndex = i + 1
                }
                if isSorted { break }
            }
            end = sortedIndex
        }
    }
}
