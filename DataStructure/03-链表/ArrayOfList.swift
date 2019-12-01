//
//  ArrayOfList.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/16.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class ArrayOfList<T>: List {
    private var arr: Array<T?>
    
    private var defaultCapacity = 10
    
    init(capacity: Int) {
        arr = Array<T>()
    }
    
    convenience init() {
        self.init(capacity: 10)
    }
    
    
    // MARK: 实现协议
    var ELEMENT_NOT_FOUND: Int = -1
    var count: Int = 0
    
    func clear() {
        for i in 0 ..< count {
            arr[i] = nil
        }
        
        let currentSize = count
        
        count = 0
        
        // 以下是缩容操作
        if currentSize > defaultCapacity {
            arr = [T?]()
        }
    }
    
    func get(idx: Int) -> T? {
        rangeOfCheck(idx: idx)
        return arr[idx]
    }
    
    func set(ele: T?, idx: Int) -> T? {
        rangeOfCheck(idx: idx)
        
        let old = arr[idx]
        arr[idx] = ele
        
        return old
    }
    
    func add(ele: T?, idx: Int) {
        rangeOfCheckForAdd(idx: idx)
        ensureCapacity(capacity: count + 1)
        
        var size = count
        while size > idx {
            arr[size] = arr[size - 1]
            size -= 1
        }
        arr[idx] = ele
        count += 1
    }
    
    func remove(idx: Int) -> T? {
        /*
        * 最好：O(1)
        * 最坏：O(n)
        * 平均：O(n)
        */
        rangeOfCheck(idx: idx)
        
        let oldEle = arr[idx]
        
        var i = idx
        while i < count - 1 {
            arr[i] = arr[i + 1]
            i += 1
        }
        count -= 1
        return oldEle
    }
    
    func indexOf(ele: T?) -> Int {
        if contain(ele: ele) {
//            for i in 0 ..< count {
//                if arr[i] == ele
//                return i
//            }
            return 0
        } else {
            return ELEMENT_NOT_FOUND
        }
    }

    //MARK: 私有方法
    private func ensureCapacity(capacity: Int) {
        guard capacity >= defaultCapacity else {
            return
        }
        
        defaultCapacity = capacity + (capacity >> 1)
        var newElements: [T?] = [T]()
        for i in 0 ..< count {
            newElements[i] = arr[i]
        }
        arr = newElements
    }
}

extension ArrayOfList: Comparetor {
    func compare(v2: T?, compareClosure: @escaping () -> Bool) -> Bool {
        true
    }
}
