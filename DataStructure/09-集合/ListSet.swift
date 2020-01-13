//
//  ListSet.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/13.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class ListSet<T: Comparable>: SetProtocal {
    private let list = LinkedList<T>(first: nil, last: nil)
    
    // MARK: 对外提供接口
    func size() -> Int {
        list.size()
    }
    
    func isEmpty() -> Bool {
        list.isEmpty()
    }
    
    func clear() {
        list.clear()
    }
    
    func contain(ele: T) -> Bool {
        list.contain(ele: ele)
    }
    
    func add(ele: T) {
        let idx = list.indexOf(ele: ele)
        if idx != list.ELEMENT_NOT_FOUND {
            /// 不存在就添加
            list.add(ele: ele)
        } else {
            /// 存在就覆盖
            list.set(ele: ele, idx: idx)
        }
    }
    
    func remove(ele: T) {
        let idx = list.indexOf(ele: ele)
        if idx != list.ELEMENT_NOT_FOUND {
            list.remove(idx: idx)
        }
    }
    
    func traversal(visitor: ((T) -> Bool)) {
        for i in 0 ..< size()  {
            let ele = list.get(idx: i)
            if let ele = ele {
                if visitor(ele) {
                    return
                }
            } else {
                continue
            }
        }
    }
}
