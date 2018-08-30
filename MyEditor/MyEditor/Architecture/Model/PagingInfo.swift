//
//  PagingInfo.swift
//  MyEditor
//
//  Created by Do Hung on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import OrderedSet

struct PagingInfo<T> {
    let page: Int
    let items: [T]
    
    init(items: [T]) {
        self.page = 1
        self.items = items
    }
    
    init(page: Int, items: [T]) {
        self.page = page
        self.items = items
    }
}

