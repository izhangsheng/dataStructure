//
//  QuickSort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/21.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class QuickSort<T: Comparable>: Sort<T> {

    override func sort() {
        sort(begin: 0, end: array.count)
    }
    
    /// 对 [begin, end) 范围的数据进行快速排序
    /// - Parameters:
    ///   - begin: 开始下标
    ///   - end: 结束b下标（左闭右开）
    private func sort(begin: Int, end: Int) {
        // 至少有一个元素才进行排序（右开，所以 >= 2）
        guard end - begin >= 2 else { return }
        
        // 确定轴点位置
        let mid = searchPivotIndex(begin: begin, end: end)
        // 对子序列进行快速排序
        sort(begin: begin, end: mid)
        sort(begin: mid + 1, end: end)
    }
    
    /// 构造出 [begin, end) 范围的轴点元素
    /// - Parameters:
    ///   - begin: begin
    ///   - end: end
    private func searchPivotIndex(begin: Int, end: Int) -> Int {
        // 随机选择一个元素跟begin位置进行交换，达到随机选择轴点元素
        let range = 1 ... (end - begin - 1)
        swap(i1: begin, i2: Int.random(in: range) + begin)
        
        // end指向最后一个元素
        var newEnd = end - 1
        var newBegin = begin
        // 备份begin位置的元素
        let pivot = array[begin]
        
        while newBegin < newEnd {
            // 从右到左和轴点元素进行大小比较挪动元素
            while newBegin < newEnd {
                if compare(v1: pivot, v2: array[newEnd]) { // 右边元素 > 轴点元素
                    newEnd -= 1
                } else {
                    array[newBegin] = array[newEnd]
                    newBegin += 1
                    break
                }
            }
            // 从左到右和轴点元素进行大小比较挪动元素
            while newBegin < newEnd {
                if compare(v1: array[newBegin], v2: pivot) { // 轴点元素 > 左边元素
                    newBegin += 1
                } else {
                    array[newEnd] = array[newBegin]
                    newEnd -= 1
                    break
                }
            }
        }
        
        // 将轴点元素放入最终的位置
        array[newBegin] = pivot
        return newEnd // newBegin == newEnd 排序完成
    }
}
