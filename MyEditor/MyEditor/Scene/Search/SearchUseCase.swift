//
//  SearchUseCase.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SearchUseCaseType {
    func readHistory() -> [String]
    func saveHistory(histories: [String])
    func updateArrayHistory(histories: [String], searchKey: String, maxHistoryCount: Int) -> [String]
}

struct SearchUseCase: SearchUseCaseType {
    func readHistory() -> [String] {
        return readHistorySearch()
    }
    
    func saveHistory(histories: [String]) {
        return saveHistorySearch(histories: histories)
    }
    
    func updateArrayHistory(histories: [String], searchKey: String, maxHistoryCount: Int) -> [String] {
        var latestArray = histories
        let index = findIndex(of: searchKey, inArray: histories)
        if let index = index {
            latestArray.remove(at: index)
        } else {
            if latestArray.count >= maxHistoryCount {
                latestArray.remove(at: maxHistoryCount - 1)
            }
        }
        latestArray.insert(searchKey, at: 0)
        return latestArray
    }
}
