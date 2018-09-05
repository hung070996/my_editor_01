//
//  CollectionImagesViewModel.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 9/5/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import RxSwift
import RxCocoa

struct CollectionImagesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectPhotoTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let photos: Driver<[Photo]>
        let selectedPhoto: Driver<Void>
        let isEmptyData: Driver<Bool>
    }
    
    let useCase: CollectionImagesUseCaseType
    let collection: Collection
    
    func transform(_ input: Input) -> Output {
        let loadMoreOutput = setupLoadMorePagingWithParam(
            loadTrigger: input.loadTrigger,
            getItems: { (_) -> Observable<PagingInfo<Photo>> in
                self.useCase.getPhotos(collection: self.collection)
            },
            refreshTrigger: input.reloadTrigger,
            refreshItems: { (_) -> Observable<PagingInfo<Photo>> in
                self.useCase.getPhotos(collection: self.collection)
            },
            loadMoreTrigger: input.loadMoreTrigger) { (_, page) -> Observable<PagingInfo<Photo>> in
                self.useCase.getPhotos(collection: self.collection, page: page)
            }
        let (page, fetchItem, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        let photos = page
            .map { $0.items }
            .asDriverOnErrorJustComplete()
        let selectedPhoto = input.selectPhotoTrigger
            .withLatestFrom(photos) { indexPath, photos in
                return photos[indexPath.row]
            }
            .do(onNext: { photos in
                //MARK: NEXT_TASK
                print("For next task - navigator")
            })
            .mapToVoid()
        let isEmptyData = Driver.combineLatest(photos, loading)
            .filter { !$0.1 }
            .map { $0.0.isEmpty }
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItem,
            photos: photos,
            selectedPhoto: selectedPhoto,
            isEmptyData: isEmptyData
        )
    }
}
