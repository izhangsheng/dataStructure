//
//  BigO.swift
//  DataStructure
//
//  Created by 张胜 on 2019/11/12.
//  Copyright © 2019 张胜. All rights reserved.
//

import Foundation

func test1(n: Int) {
    // O(1)
    if n > 10 {
        print("n > 10")
    } else if n > 5 {
        print("10 > n > 5")
    } else {
        print("n < 5")
    }
    
    // 1 + 4 + 4 + 4
    for _ in 0 ... 4 {
        print("test")
    }
    
    // 140000
    // O(1)
    // O(1)
}

// O(n)
func test2(n: Int) {
    for _ in 0 ... n {
        print("test")
    }
}

// 大O表示法时间复杂度为O(n^2)
public func test3(n: Int) {
    // 1 + 2n + n * (1 + 3n)
    // 1 + 2n + n + 3n^2
    // 3n^2 + 3n + 1
    // O(n^2)
    for _ in 0 ... n {
        for _ in 0 ... n {
            print("***")
        }
    }
}

// 大O表示法时间复杂度为O(log5(n))->O(logn)
public func test4(n: Int) {
    var i = n
    while i > 0 {
        i = i / 5
        print("**")
    }
}

public func test5(n: Int) {
    // 8 = 2^3
    // 16 = 2^4
    
    // 3 = log2(8)
    // 4 = log2(16)
    
    // 执行次数 = log2(n)
    // O(logn)
    var v: Int = n
    
    while v > 0 {
        v /= 2
        print("**")
    }
}
