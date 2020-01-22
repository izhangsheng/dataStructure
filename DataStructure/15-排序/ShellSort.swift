//
//  ShellSort.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/22.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

class ShellSort<T: Comparable>: Sort<T> {
    override func sort() {
        for element in shellStepSequence() {
            sort(withStep: element)
        }
    }
    
    /// 分成step列进行排序
    /// - Parameter step: 步长
    private func sort(withStep step: Int) {
        // 对每一列进行插入排序， col : 第几列，column的简称，
        for col in 0 ..< step {
            // col、col + step、col + 2 * step、col + 3 * step
            var begin = col + step
            while begin < array.count {
                var cur = begin
                while cur > col, compare(i1: cur, i2: cur - step) {
                    swap(i1: cur, i2: cur - step)
                    cur -= step
                }
                
                begin += step
            }
        }
    }
    
    private func shellStepSequence() -> [Int] {
        var stepSequence = [Int]()
        var step = array.count >> 1
        
        while step > 0 {
            stepSequence.append(step)
            step = step >> 1
        }
        return stepSequence
    }
}
