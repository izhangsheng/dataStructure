//
//  MinHeap.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/14.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class MinHeap<T: Comparable>: BinaryHeap<T> {
    init(elements: [T]) {
        super.init(elements: elements, isBig: false)
    }
}
