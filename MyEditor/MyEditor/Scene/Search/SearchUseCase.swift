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
}

struct SearchUseCase: SearchUseCaseType {
    func readHistory() -> [String] {
        return readHistorySearch()
    }
    
    func saveHistory(histories: [String]) {
        return saveHistorySearch(histories: histories)
    }
}
