//
//  DynamicArray.swift
//  DataStructure
//
//  Created by 张胜 on 2019/10/24.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

class DynamicArray<Eliment> {
    private var size_: Int = 0
    private var list: NSArray?
    
    public init(capacity: Int) {
        _ = capacity > 10 ? capacity : 10
        
        list = NSArray.init()
    }
    
    public func isEmpty(eliment: Eliment) -> Bool {
        return size_ == 0
    }
    
    public func contain(eliment: Eliment) -> Bool {
        return true
    }
    
    public func size() -> Int {
        return size_
    }
    
    public func add(eliment: Eliment) {
        
    }
    
    public func clear() {
        
    }
}
