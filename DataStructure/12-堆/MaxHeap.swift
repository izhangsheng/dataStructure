//
//  MaxHeap.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/6/3.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

class MaxHeap<T: Comparable>: BinaryHeap<T> {
    init(elements: [T]) {
        super.init(elements: elements, isBig: true)
    }
}
