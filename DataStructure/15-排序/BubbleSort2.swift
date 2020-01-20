//
//  BubbleSort2.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class BubbleSort2<T>: Sort<T> where T: Comparable {
    override func sort() {
        let end = array.count
        
        for i in 0 ..< end {
            // 如果已经为有序，提前终止排序
            var isSorted = true
            for j in 0 ..< end - i - 1 {
                if compare(i1: j + 1, i2: j) {
                    swap(i1: j, i2: j + 1)
                    isSorted = false
                }
            }
            if isSorted { break }
        }
    }
}
