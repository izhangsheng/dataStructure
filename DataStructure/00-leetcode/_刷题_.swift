//
//  _刷题_.swift
//  DataStructure
//
//  Created by 张胜 on 2021/2/23.
//  Copyright © 2021 张胜. All rights reserved.
//

import Foundation

class Permute {
    
    /// 给定一个没有重复数字的序列，返回其所有可能的全排列。
    /// - Parameter nums: 一组无重复数字
    /// - Returns: 结果
    func permute(nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var curPath = [Int]()
        
        pathSelect(nums: nums, paths: &result, curPath: &curPath)
        
        return result
    }
    
    func pathSelect(nums: [Int], paths: inout [[Int]], curPath: inout [Int]) {
        // 所有数都填完了
        if curPath.count == nums.count {
            paths.append(curPath)
            return
        }
        
        for num in nums {
            if curPath.contains(num) {
                continue
            }
            
            curPath.append(num)
            pathSelect(nums: nums, paths: &paths, curPath: &curPath)
            curPath.removeLast()
        }
    }
}

class NQueues {
    private var places: Int = 0 // 一共有多少种摆法
    /// 数组索引是行号，数组元素是列号
    var queues: [Int] = [Int]()
    /// 左上角到右下角所有对角线的集合，每个线对应的元素代表是否有放皇后
    /// 右上角到左下角所有对角线的集合，每个线对应的元素代表是否有皇后
    var ltrTop = [Bool]()
    var rtlTop = [Bool]()
    /// 标记某一列是否有皇后
    var cols = [Int]()
    
    var solutions = [[String]]()
    
    
    /// 1 <= n <= 9皇后彼此不能相互攻击，也就是说：任何两个皇后都不能处于同一条横行、纵行或斜线上。
    /// - Parameter n: 棋盘
    /// - Returns: 结果
    func solveNQueens(_ n: Int) -> [[String]] {
        /// 数组索引是行号，数组元素是列号
        queues = Array(repeating: -1, count: n)
        /// 左上角到右下角所有对角线的集合，每个线对应的元素代表是否有放皇后
        /// 右上角到左下角所有对角线的集合，每个线对应的元素代表是否有皇后
        ltrTop = Array(repeating: false, count: 2 * n - 1)
        rtlTop = Array(repeating: false, count: 2 * n - 1)
        /// 标记某一列是否有皇后
        cols = Array(repeating: -1, count: n)
        
        placeQueue(at: 0)
        
        return solutions
    }
    
    func placeQueue(at row: Int) {
        if row >= queues.count {
            // 摆法
//            places += 1
            return
        }
        
        for col in 0 ..< queues.count {
            if queues[row] == col {
                continue
            }
            let ltrIdx = row - col + queues.count
            if ltrTop[ltrIdx] {
                continue
            }
            let rtlIdx = col + row
            if rtlTop[rtlIdx] {
                continue
            }
            queues[row] = col
            cols[row] = col
            rtlTop[rtlIdx] = true
            placeQueue(at: row + 1)
            ltrTop[col] = false
            rtlTop[col] = false
            cols[row] = -1
        }
    }
    
    func generateBoard() {
        var places = [String]()
        for i in cols {
            var place = ""
            for j in 0 ..< cols.count {
                if i == j {
                    place.append("Q")
                } else {
                    place.append(".")
                }
            }
            places.append(place)
        }
        solutions.append(places)
    }
}
