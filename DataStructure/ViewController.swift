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
        
        let nodeList = LinkedList<Int>(first: nil, last: nil)
        nodeList.add(ele: 1)
        nodeList.add(ele: 2)
        nodeList.add(ele: 3)
        nodeList.add(ele: 4)
//        nodeList.remove(idx: 3)
//        nodeList.add(ele: 2, idx: 1)
        nodeList.set(ele: 8, idx: 0)
        let des = nodeList.toString()
        print("")
    }
}

