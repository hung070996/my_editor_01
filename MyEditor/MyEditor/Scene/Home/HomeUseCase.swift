//
//  HomeUseCase.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import RxSwift

protocol HomeUseCaseType {
    func getPhotos() -> Observable<PagingInfo<Photo>>
    func getRandomPhoto() -> Observable<Photo>
    func getPhotos(page: Int) -> Observable<PagingInfo<Photo>>
    func getCollections() -> Observable<PagingInfo<Collection>>
    func getCollections(page: Int) -> Observable<PagingInfo<Collection>>
}

struct HomeUseCase: HomeUseCaseType {
    func getPhotos() -> Observable<PagingInfo<Photo>> {
        let repository = ImageRepository(api: APIService.share)
        return repository.getNewPhotos()
            .map { photos in
                return PagingInfo(items: photos)
            }
    }
    
    func getRandomPhoto() -> Observable<Photo> {
        let repository = ImageRepository(api: APIService.share)
        return repository.getRandomPhoto()
    }
    
    func getPhotos(page: Int) -> Observable<PagingInfo<Photo>> {
        let repository = ImageRepository(api: APIService.share)
        return repository.getNewPhotos(page: page)
            .map { photos in
                return PagingInfo(page: page, items: photos)
            }
    }
    
    func getCollections() -> Observable<PagingInfo<Collection>> {
        let repository = CollectionRepository(api: APIService.share)
        return repository.getListCollection()
            .map { collections in
                return PagingInfo(items: collections)
            }
    }
    
    func getCollections(page: Int) -> Observable<PagingInfo<Collection>> {
        let repository = CollectionRepository(api: APIService.share)
        return repository.getListCollection(page: page)
            .map { collections in
                return PagingInfo(page: page, items: collections)
            }
    }
}
