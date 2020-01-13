//
//  SetProtocal.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/13.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

protocol SetProtocal {
    associatedtype Element
    func size() -> Int
    func isEmpty() -> Bool
    func clear() -> Void
    func contain(ele: Element) -> Bool
    func add(ele: Element) -> Void
    func remove(ele: Element) -> Void
    func traversal(visitor: ((Element) -> Bool))
}
