//
//  Fib1.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/12.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation


/// 0 1 1 2 3 5 8... 斐波那契数列
/// - Parameter n: 参数
func fib1(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    
    return fib1(n - 1) + fib1(n - 2)
}

func fib2(_ n: Int) -> Int {
    guard n > 1 else {
        return n
    }
    
    var first = 0
    var second = 1
    for _ in 0 ..< n - 1 {
        second = first + second
        first = second - first
    }
    return second
}

func fib3(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    
    var first: Int = 0
    var second: Int = 1
    var sum: Int = 0
    var v: Int = n
    
    while v > 1 {
        sum = first + second
        first = second
        second = sum
        v -= 1
    }
    return sum
}
