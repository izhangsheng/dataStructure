//
//  ArrayList.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/14.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

public class ArrayList<Element: Comparable> {
    /// 元素的数量
    private var _size: Int = 0
    
    private var defaultCapacity: Int = 10
    
    private var noElement: Int = -1
    
    private var elements: Array<Element?>
    
    public init(capacity: Int) {
//        let realCapacity = (capacity < defaultCapacity) ? defaultCapacity : capacity
        elements = Array<Element>()
    }
    
//    public convenience init() {
//        init(capacity: defaultCapacity)
//    }
}

public extension ArrayList {
    func set(obj: Element, at index: Int) {
        rangeCheck(index: index)
        ensureCapacity(capacity: index)
        
        var i = _size
        while i > index {
            elements[i] = elements[i - 1]
            i -= 1
        }
        elements[index] = obj
    }
    
    func get(idx: Int) -> Element? {
        rangeCheck(index: idx)
        return elements[idx]
    }
    
    func clear() {
        for i in 0 ..< _size {
            elements[i] = nil
        }
        _size = 0
    }
    
    func size() -> Int {
        _size
    }
    
    func isEmpty() -> Bool {
        return _size == 0
    }
    
    func add(_ element: Element) {
        elements.append(element)
        _size += 1
    }
    
    func add(index: Int, element: Element) {
        rangeCheckForAdd(index: index)
        ensureCapacity(capacity: _size + 1)
        var i = _size
        
        while i > index {
            elements[i] = elements[i - 1]
            i -= 1
        }
        elements[index] = element
        _size += 1
    }
    
    func contain(obj: Element?) -> Bool {
        for e in elements {
            if e == obj {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func remove(element: Element?) {
        if contain(obj: element) {
            var idx = indexOf(obj: element)
            while idx < _size {
                elements[idx] = elements[idx + 1]
                idx += 1
            }
            _size -= 1
        }
    }
    
    private func rangeCheck(index: Int) {
        if index < 0 || index >= _size {
            fatalError()
        }
    }
    
    func remove(index: Int) -> Element? {
        rangeCheck(index: index)
        let oldE: Element? = elements[index]
        remove(element: oldE)
        
        return oldE
    }
    
    
    
    func indexOf(obj: Element?) -> Int {
        for i in 0 ..< _size {
            if elements[i] == obj {
                return i
            }
        }
        return noElement
    }
    
    func remove(at index: Int) -> Element? {
        rangeCheckForAdd(index: index)
        let oldElement: Element? = elements[index]
        for i in index ..< _size - 1 {
            elements[i] = elements[i + 1]
        }
        elements[_size - 1] = nil
        _size -= 1
        return oldElement
    }
    
    func rangeCheckForAdd(index: Int) {
        if index < 0 || index > _size {
            fatalError("超过容量了")
        }
    }
    
    func ensureCapacity(capacity: Int) {
        guard capacity >= defaultCapacity else {
            return
        }
        
        defaultCapacity = capacity + (capacity >> 1)
        var newElements: [Element?] = [Element]()
        for i in 0 ..< _size {
            newElements[i] = elements[i]
        }
        elements = newElements
    }
}
