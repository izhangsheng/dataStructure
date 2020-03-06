//
//  ViewController.swift
//  DataStructure
//
//  Created by 张胜 on 2019/10/24.
//  Copyright © 2019 张胜. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
    }
    
    func test() {
        let count = lcs(str1: "aocdfve", str2: "pmcdfe")
        print(count)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var arr = [Int]()
        let range = 0 ... 3000
        for _ in range {
            arr.append(Int.random(in: range))
        }
        
//        var arr = [1, 4, 2, 7, 5, 10, 8, 9, 3, 6, 8]
        
        selectionSort(arr: &arr)
        bubbleSort1(arr: &arr)
        bubbleSort2(arr: &arr)
        bubbleSort3(arr: &arr)
        heapSort(arr: &arr)
        insertionSort1(arr: &arr)
        insertionSort2(arr: &arr)
        insertionSort3(arr: &arr)
        mergeSort(arr: &arr)
        quickSort(arr: &arr)
        shellSort(arr: &arr)
    }
    
    
    func selectionSort(arr: inout [Int]) {
        let sort = SelectionSort<Int>()
        sort.sort(withElements: &arr)
        print("selectionSort：\(sort.description)")
    }
    
    func bubbleSort1(arr: inout [Int]) {
        let sort = BubbleSort1<Int>()
        sort.sort(withElements: &arr)
        print("bubbleSort1：\(sort.description)")
    }
    
    func bubbleSort2(arr: inout [Int]) {
        let sort = BubbleSort1<Int>()
        sort.sort(withElements: &arr)
        print("bubbleSort2：\(sort.description)")
    }
    
    func bubbleSort3(arr: inout [Int]) {
        let sort = BubbleSort1<Int>()
        sort.sort(withElements: &arr)
        print("bubbleSort3：\(sort.description)")
    }
    
    func heapSort(arr: inout [Int]) {
        let sort = HeapSort<Int>()
        sort.sort(withElements: &arr)
        print("heapSort：\(sort.description)")
    }
    
    func insertionSort1(arr: inout [Int]) {
        let sort = InsertionSort1<Int>()
        sort.sort(withElements: &arr)
        print("insertionSort1：\(sort.description)")
    }
    
    func insertionSort2(arr: inout [Int]) {
        let sort = InsertionSort2<Int>()
        sort.sort(withElements: &arr)
        print("insertionSort2：\(sort.description)")
    }
    
    func insertionSort3(arr: inout [Int]) {
        let sort = InsertionSort3<Int>()
        sort.sort(withElements: &arr)
        print("insertionSort3：\(sort.description)")
    }
    
    func mergeSort(arr: inout [Int]) {
        let sort = MergeSort<Int>()
        sort.sort(withElements: &arr)
        print("mergeSort：\(sort.description)")
    }
    
    func quickSort(arr: inout [Int]) {
        let sort = QuickSort<Int>()
        sort.sort(withElements: &arr)
        print("quickSort：\(sort.description)")
    }
    
    func shellSort(arr: inout [Int]) {
        let sort = ShellSort<Int>()
        sort.sort(withElements: &arr)
        print("shellSort：\(sort.description)")
    }
}

