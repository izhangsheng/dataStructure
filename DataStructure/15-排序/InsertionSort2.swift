//
//  InsertionSort2.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/21.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class InsertionSort2<T: Comparable>: Sort<T> {
    override func sort() {
        for i in 1 ..< array.count {
            var curIndex = i
            let v = array[curIndex]
            
            while curIndex > 0, compare(v1: v, v2: array[curIndex - 1]) {
                // 挪动位置
                array[curIndex] = array[curIndex - 1]
                curIndex -= 1
            }
            array[curIndex] = v
        }
    }
}
