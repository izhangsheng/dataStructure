//
//  BloomFilter.swift
//  DataStructure
//
//  Created by zhangsheng on 2021/6/28.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

public class BloomFilter<T> where T: Hashable {
    private struct InitError: Error {
        enum IllegalArgument {
            case n(String)
            case p(String)
        }
        
        private var errorDes: IllegalArgument
        init(errorDes: IllegalArgument) {
            self.errorDes = errorDes
        }
    }
    
    // 二进制向量的长度（一共有多少个二进制位）
    private var bitSize: Int
    // 二进制向量
    private var bits: [Int64]
    // 哈希函数的个数
    private var hashSize: Int
    
    /// 初始化函数
    /// - Parameters:
    ///   - n: 数据规模
    ///   - p: 误判率，取值范围（0-1）
    init(_ n: Int, _ p: Double) throws {
        if n <= 0 {
            throw InitError(errorDes: InitError.IllegalArgument.n("n参数必须大于0"))
        } else if p <= 0 || p >= 1 {
            throw InitError(errorDes: InitError.IllegalArgument.p("p参数必须大于0且小于1"))
        }
        
        let ln = log(2.0)
        // 求出二进制向量的长度
        bitSize = Int(-(Double(n) * log(p)) / (ln * ln))
        // 求出哈希函数的个数
        hashSize = bitSize * Int(ln / Double(n))
        // 每一页显示100条数据, pageSize
        // 一共有999999条数据, n
        // 请问有多少页 pageCount = (n + pageSize - 1) / pageSize
        let count = Int((bitSize + Int64.bitWidth - 1) / Int64.bitWidth)
        bits = Array(repeating: 0, count: count)
    }
    
    // MARK: public
    /// 添加元素
    /// - Parameter value: value
    public func put(value: T) -> Bool {
        let hash1 = value.hashValue
        let hash2 = hash1 >> 16
        
        var result = false
        for i in 0 ... hashSize {
            var combinedHash = hash1 + (i * hash2)
            if combinedHash < 0 {
                combinedHash = ~combinedHash
            }
            
            // 生成一个二进制位的索引
            let index = combinedHash % bitSize
            if set(index: index) {
                result = true
            }
        }
        
        return result
    }
    
    public func contain(value: T) -> Bool {
        let hash1 = value.hashValue
        let hash2 = hash1 >> 16
        for i in 0 ... hashSize {
            var combinedHash = hash1 + (i * hash2)
            if combinedHash < 0 {
                combinedHash = ~combinedHash
            }
            
            // 生成一个二进制位的索引
            let index = combinedHash % bitSize
            if (!get(index: index)) { return false }
        }
        return true
    }
    
    // MARK: private
    private func set(index: Int) -> Bool {
        let value = bits[Int(index / Int64.bitWidth)]
        let bitValue = Int64(1 << Int(index % Int64.bitWidth))
        bits[Int(index / Int64.bitWidth)] = value | bitValue
        return (value & bitValue) == 0
    }
    
    private func get(index: Int) -> Bool {
        let value = bits[Int(index / Int64.bitWidth)]
        return (value & (1 << Int(index % Int64.bitWidth))) != 0
    }
}
