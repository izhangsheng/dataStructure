//
//  BubbleSort1.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class BubbleSort1<T>: Sort<T> where T: Comparable {
//    override func sort() {
//        var end = array.count - 1
//
//        while end > 0 {
//            for i in 0 ..< end {
//                if compare(i1: i + 1, i2: i) {
//                    swap(i1: i, i2: i + 1)
//                }
//            }
//            end -= 1
//        }
//    }
    
    override func sort() {
        let end = array.count
        
        for i in 0 ..< end {
            for j in 0 ..< end - i - 1 {
                if compare(i1: j + 1, i2: j) {
                    swap(i1: j, i2: j + 1)
                }
            }
        }
    }
}
