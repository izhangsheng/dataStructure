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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var arr = [7, 2, 9, 4, 7, 10, 5, 1, 8]
        selectionSort(arr: &arr)
        bubbleSort1(arr: &arr)
    }
    
    
    func selectionSort(arr: inout [Int]) {
        let sort = SelectionSort<Int>()
        sort.sort(withElements: &arr)
        print("selectionSort：\(sort.array!)")
    }
    
    func bubbleSort1(arr: inout [Int]) {
        let sort = BubbleSort1<Int>()
        sort.sort(withElements: &arr)
        print("bubbleSort1：\(sort.array!)")
    }
}

