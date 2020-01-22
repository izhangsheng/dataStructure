//
//  Sort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/20.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class Sort<Element> where Element: Comparable {
    var array: [Element]!
    private var cmpCount = 0
    private var swapCount = 0
    private var time: Double = 0
    
    public func sort(withElements elements: inout [Element]) {
        guard elements.count > 1 else { return }
        array = elements
        let begin = CFAbsoluteTimeGetCurrent() // *1000 是精确到毫秒，不乘就是精确到秒
        sort()
        time = CFAbsoluteTimeGetCurrent() - begin
    }
    
    internal func sort() { }
    
    /// 比较i1位置元素是否比i2位置元素小
    /// - Parameters:
    ///   - i1: 索引1
    ///   - i2: 索引2
    internal func compare(i1: Int, i2: Int) -> Bool {
        cmpCount += 1
        return array[i1] < array[i2]
    }
    
    /// 比较左右两个元素的大小
    /// - Parameters:
    ///   - i1: 索引1
    ///   - i2: 索引2
    internal func compare(v1: Element, v2: Element) -> Bool {
        cmpCount += 1
        return v1 < v2
    }
    
    internal func swap(i1: Int, i2: Int) {
        swapCount += 1
        let tmp = array[i1]
        array[i1] = array[i2]
        array[i2] = tmp
    }
}

extension Sort: CustomStringConvertible {
    var description: String {
        let second = String(format: "%.2f", time)
        let millisecond = String(format: "%.2f", time * 1000)
        
        
        let timeStr = "耗时：\(second)s" + "(\(millisecond)ms)"
        let compareCountStr = "比较：" + numberOfString(num: cmpCount)
        let swapCountStr = "交换：" + numberOfString(num: swapCount)
//        let stableStr = "稳定性：" + isStable();
        return "【\(type(of: self))】\n"
                + timeStr + " \t"
                + compareCountStr + "\t"
                + swapCountStr + "\n"
                + "------------------------------------------------------------------"
    }
    
    private func numberOfString(num: Int) -> String {
        let formateNum = Double(num)
        
        if formateNum < 10000.00 { return "\(formateNum)次" }
        if formateNum < 100000000 { return " \(formateNum / 10000.0)万次" }
        return "  \(formateNum / 100000000.0)亿次"
    }
}
