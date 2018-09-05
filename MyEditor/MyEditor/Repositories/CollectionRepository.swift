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
    func getImagesInCollection(collection: Collection, page: Int, perPage: Int) -> Observable<[Photo]>
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
    
    func getImagesInCollection(collection: Collection, page: Int = 1, perPage: Int = 10) -> Observable<[Photo]> {
        let request = PhotoInCollectionRequest(collection: collection, page: page, perPage: perPage)
        return api.request(input: request)
            .map { (output: PhotoResponse) -> [Photo] in
                return output.listPhotos
            }
    }
}
