//
//  SelectionSort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class SelectionSort<T: Comparable>: Sort<T> {
//    override func sort() {
//        var end = array.count - 1
//
//        while end > 0 {
//            var max = 0
//            for begin in 1 ... end {
//                if compare(i1: max, i2: begin) {
//                    max = begin
//                }
//            }
//            swap(i1: max, i2: end)
//            end -= 1
//        }
//    }
    
    override func sort() {
        var begin = 0
        let end = array.count

        while begin < end {
            var min = end - 1
            for i in begin ..< end - 1 {
                if compare(i1: i, i2: min) {
                    min = i
                }
            }
            swap(i1: begin, i2: min)
            begin += 1
        }
    }
}
