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
        
//        test()
        
        var a = 0;
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent(), 1, 0, 0) { (timer) in
            a += 1
            print("a是多少啊\(a)")
            if a > 20 {
                CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.defaultMode);
            }
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.defaultMode);
        
    }
    
    func test() {
        let count = lcs(str1: "aocdfve", str2: "pmcdfe")
        print(count)
    }
    
}

