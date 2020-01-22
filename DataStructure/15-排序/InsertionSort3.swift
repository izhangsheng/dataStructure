//
//  InsertionSort3.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/21.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class InsertionSort3<T: Comparable>: Sort<T> {
    override func sort() {
        for i in 1 ..< array.count {
            insert(withSourceIndex: i, toDestination: searchForInsertIndex(withIndex: i))
        }
    }
    
    /// 原始位置的元素和目标元素交换
    /// - Parameters:
    ///   - source: 原始index
    ///   - des: 目标（待插入）index
    private func insert(withSourceIndex source: Int, toDestination des: Int) {
        var curIdx = source
        let v = array[source]
        
        while curIdx > des {
            array[curIdx] = array[curIdx - 1]
            curIdx -= 1
        }
        array[des] = v
    }
    
    /// 利用二分搜索找到 idx 位置元素待插入的下标
    /// - Parameter idx: index
    private func searchForInsertIndex(withIndex idx: Int) -> Int {
        var begin = 0
        var end = idx
        while end > begin {
            let mid = (begin + end) >> 1
            if array[idx] < array[mid] {
                end = mid
            } else {
                begin = mid + 1
            }
        }
        return begin
    }
}
