//
//  InsertionSort1.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/21.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class InsertionSort1<T: Comparable>: Sort<T> {
    override func sort() {
        for i in 1 ..< array.count {
            var curIndex = i
            while curIndex > 0, compare(i1: curIndex, i2: curIndex - 1) {
                // 交换值
                swap(i1: curIndex, i2: curIndex - 1)
                curIndex -= 1
            }
        }
    }
}
