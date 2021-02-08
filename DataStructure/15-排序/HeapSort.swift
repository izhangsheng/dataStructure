//
//  HeapSort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class HeapSort<T: Comparable>: Sort<T> {
    private var heapSize = 0
    
    override func sort() {
        heapSize = array.count
        
        // 原地建堆，end为最后一个拥有子节点在数组中的下标
        var end = heapSize >> 1 - 1
        while end >= 0 {
            siftDown(end)
            end -= 1
        }
        
        while heapSize > 1 {
            // 交换堆顶元素和尾部元素
            swap(i1: 0, i2: heapSize - 1)

            heapSize -= 1
            
            // 对0位置进行siftDown（恢复堆的性质）
            siftDown(0)
        }
    }
    
    /// 自下而上的下虑
    /// - Parameter index: 下标
    private func siftDown(_ index: Int) {
        let element = array[index]
        // half为第一个叶子节点的下标
        let half = heapSize >> 1
        // 第一个叶子节点的索引 == 非叶子节点的数量
        // index < 第一个叶子节点的索引
        // 必须保证index位置是非叶子节点
        
        var newIdx = index
        
        while newIdx < half {
            // index的节点有2种情况
            // 1.只有左子节点
            // 2.同时有左右子节点
            
            // 默认为左子节点跟它进行比较
            var childIdx = (newIdx << 1) + 1
            var childEle = array[childIdx]
            
            // 右子节点
            let rightChildIdx = childIdx + 1
            let rightChildEle = array[rightChildIdx]
            
            // 选出左右子节点最大的那个
            if (rightChildIdx < heapSize), (rightChildEle > childEle) {
                childEle = rightChildEle
                childIdx = rightChildIdx
            }
            
            if element > childEle { break }
            
            // 将子节点存放到index位置
            array[newIdx] = childEle
            // 重新设置index
            newIdx = childIdx
        }
        array[newIdx] = element
    }
}
