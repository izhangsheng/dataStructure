//
//  File.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/16.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public protocol List {
    var ELEMENT_NOT_FOUND: Int {
        get
    }
    
    var count: Int {
        set
        get
    }
    
    associatedtype T
    
    func clear() -> Void

    /// 大小
    func size() -> Int
    
    /// 是否为空
    func isEmpty() -> Bool

    /// 是否包含某个元素
    /// - Parameter element: 元素
    func contain(ele: T?) -> Bool

    /// 添加元素到尾部
    /// - Parameter element: 元素
    func add(ele: T?) -> Void
    
    func get(idx: Int) -> T?
    
    func set(ele: T?, idx: Int) -> T?
    
    func add(ele: T?, idx: Int) -> Void
    
    func remove(idx: Int) -> T?
    
    func indexOf(ele: T?) -> Int
    
    func outOfBounds(idx: Int) -> Void
    
    func rangeOfCheck(idx: Int) -> Void
    
    func rangeOfCheckForAdd(idx: Int) -> Void
    
}

extension List {
    public func size() -> Int{
        count
    }
    
    public func isEmpty() -> Bool {
        count == 0
    }
    
    public func contain(ele: T?) -> Bool {
        return indexOf(ele: ele) == ELEMENT_NOT_FOUND
    }
    
    public func add(ele: T?) {
        add(ele: ele, idx: count)
    }
    
    public func outOfBounds(idx: Int) -> Void {
        fatalError("超出边界了")
    }
    
    public func rangeOfCheckForAdd(idx: Int) {
        if idx < 0 || idx > size() {
            outOfBounds(idx: idx)
        }
    }
    
    public func rangeOfCheck(idx: Int) {
        if idx < 0 || idx >= size() {
            outOfBounds(idx: idx)
        }
    }
    
    
    
    
}

public protocol Comparetor {
    associatedtype T
    func compare(v2: T?, compareClosure: @escaping() -> Bool) -> Bool
}
