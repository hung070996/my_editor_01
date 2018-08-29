//
//  CollectionRepository.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import RxSwift

protocol CollectionRepositoryType {
    func getListCollection(page: Int, perPage: Int) -> Observable<[Collection]>
}

final class CollectionRepository: CollectionRepositoryType {
    private var api: APIService
    
    required init(api: APIService) {
        self.api = api
    }
    
    func getListCollection(page: Int = 1, perPage: Int = 10) -> Observable<[Collection]> {
        let request = CollectionRequest(page: page, perPage: perPage)
        return api.request(input: request)
            .map { (output: CollectionResponse) -> [Collection] in
                return output.listCollections
            }
    }
}
