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
    private var elements: [Type]?
    private final var DEFAULT_CAPACITY = 10
    
    init(elements: [Type]?) {
        self.elements = elements
    }
    
    /// 堆内元素的数量
    public func size() -> Int {
        0
    }
    
    /// 堆是否为空
    public func isEmpty() -> Bool {
        false
    }
    
    /// 添加元素
    /// - Parameter ele: 元素
    public func add(withElement ele: Type) {
        
    }
    
    /// 获得堆顶元素
    public func get() -> Type? {
        nil
    }
    
    /// 删除堆顶元素并返回
    public func remove() -> Type? {
        nil
    }
    
    /// 删除堆顶元素同时插入一个新的元素
    /// - Parameter ele: 替代元素
    public func replace(withElement ele: Type) -> Type? {
        nil
    }
}
