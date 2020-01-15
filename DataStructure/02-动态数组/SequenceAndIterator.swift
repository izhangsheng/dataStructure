//
//  SequenceAndIterator.swift
//  DataStructure
//
//  Created by 张胜 on 2020/1/15.
//  Copyright © 2020 张胜. All rights reserved.
//

import Foundation

struct Novella {
    var name: String
}

/// 小说集合结构
struct Novellas {
    let novellas: [Novella]
}


extension Novellas: Sequence {
    // 实现协议方法(制作一个小说迭代器)
   func makeIterator() -> NovellaIterator {
       return NovellaIterator(novellas)
   }
}

/// 定义一个小说迭代器
struct NovellaIterator: IteratorProtocol {
    private var currentIdx = 0 // 当前索引
    private let novellas: [Novella] // 小说堆
    
    init(_ novellas: [Novella]) {
        self.novellas = novellas
    }
    
    // MARK: IteratorProtocol
    typealias Element = Novella
    mutating func next() -> Novella? {
        defer {
            currentIdx += 1
        }
        return novellas.count > currentIdx ? novellas[currentIdx] : nil
    }
}

class Test {
    let greatNovellas = Novellas(novellas: [Novella(name: "The Mist"), Novella(name: "The Mist2")])
    func traveral() {
        for novella in greatNovellas {
            print(novella.name)
        }
    }
}
