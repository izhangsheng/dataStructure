//
//  BinaryHeap.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/14.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

public class BinaryHeap<Type> where Type: Comparable {
    private var count = 0
    private var elements: [Type]
    
    init(elements: [Type]) {
        count = elements.count
        // 值得赋值是直接复制
        self.elements = elements
        heapify()
    }
    
    /// 堆内元素的数量
    public func size() -> Int {
        count
    }
    
    /// 堆是否为空
    public func isEmpty() -> Bool {
        count == 0
    }
    
    /// 添加元素
    /// - Parameter ele: 元素
    public func add(withElement ele: Type) {
        elements[count] = ele
        count += 1
        siftUp(count - 1)
    }
    
    /// 获得堆顶元素
    public func get() -> Type? {
        return elements.first
    }
    
    /// 删除堆顶元素并返回
    public func remove() -> Type? {
        guard count == 0 else { return nil }
        count -= 1
        let root = elements.first
        elements[0] = elements.last!
        elements.removeLast()
        siftDown(0)
        return root
    }
    
    /// 删除堆顶元素同时插入一个新的元素
    /// - Parameter ele: 替代元素
    public func replace(withElement ele: Type) -> Type? {
        var root: Type? = nil
        if count == 0 {
            elements[0] = ele
            count += 1
        } else {
            root = elements.first
            elements[0] = ele
            siftDown(0)
        }
        return root
    }
    
    public func clear() {
        count = 0
        elements.removeAll()
    }
}

private extension BinaryHeap {
    /// 批量建堆
    func heapify() {
//        for i in 0 ..< count {
//            siftUp(i)
//        }
        let end = count >> 1 - 1
        for i in 0 ..< end {
            siftDown(i)
        }
    }
    
    /// 自上而下的上虑
    /// - Parameter index: 下标
    func siftUp(_ index: Int) {
//        E e = elements[index];
//        while (index > 0) {
//            int pindex = (index - 1) >> 1;
//            E p = elements[pindex];
//            if (compare(e, p) <= 0) return;
//
//            // 交换index、pindex位置的内容
//            E tmp = elements[index];
//            elements[index] = elements[pindex];
//            elements[pindex] = tmp;
//
//            // 重新赋值index
//            index = pindex;
//        }
        var newIndex = index
        let element = elements[newIndex]
        while newIndex > 0 {
            let parentIndex = (newIndex - 1) >> 1
            let parent = elements[parentIndex]
            if element < parent { break }
            
            // 将父元素存储在index位置
            elements[newIndex] = parent
            
            // 重新赋值index
            newIndex = parentIndex
        }
        elements[newIndex] = element
    }
    
    /// 自下而上的下虑
    /// - Parameter index: 下标
    func siftDown(_ index: Int) {
        let element = elements[index]
        // half为第一个叶子节点的下标
        let half = count >> 1
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
            var childEle = elements[childIdx]
            
            // 右子节点
            let rightChildIdx = childIdx + 1
            let rightChildEle = elements[rightChildIdx]
            
            // 选出左右子节点最大的那个
            if (rightChildIdx < count), (rightChildEle > childEle) {
                childEle = rightChildEle
                childIdx = rightChildIdx
            }
            
            if element > childEle { break }
            
            // 将子节点存放到index位置
            elements[newIdx] = childEle
            // 重新设置index
            newIdx = childIdx
        }
        elements[newIdx] = element
    }
}
