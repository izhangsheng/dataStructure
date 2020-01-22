//
//  MergeSort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/21.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class MergeSort<T: Comparable>: Sort<T> {
    private var leftArray = [T]()
    
    override func sort() {
        sort(0, array.count)
    }
    
    /// 对 [begin, end) 范围的数据进行归并排序
    /// - Parameters:
    ///   - begin: 开始下标
    ///   - end: 结束b下标（左闭右开）
    private func sort(_ begin: Int, _ end: Int) {
        // T(n) = T(n/2) + T(n/2) + O(n)
        guard end - begin >= 2 else { return }
        let mid = (begin + end) >> 1
        sort(begin, mid)
        sort(mid, end)
        merge(begin, mid, end)
    }
    
    /// 将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
    /// - Parameters:
    ///   - begin: 左边数组开始下标
    ///   - mid: 左边数组结束下标（右开），右边数组开始下标
    ///   - end: 右边数组结束下标
    private func merge(_ begin: Int, _ mid: Int, _ end: Int) {
        var li = 0
        let le = mid - begin
        var ri = mid
        let re = end
        var ai = begin
        
        // 先清空，再备份左边数据
        leftArray.removeAll()
        for i in li ..< le {
            leftArray.append(array[begin + i])
        }
        
        // 如果左边还没有结束
        while li < le {
            if ri < re, compare(v1: array[ri], v2: leftArray[li]) {
                array[ai] = array[ri]
                ai += 1
                ri += 1
            } else {
                array[ai] = leftArray[li]
                ai += 1
                li += 1
            }
        }
    }
}
