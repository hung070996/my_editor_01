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
        let toHomeScreenTrigger: Driver<Void>
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
        let collection: Driver<Collection>
        let ratios: BehaviorRelay<[CGFloat]>
    }
    
    let navigator: CollectionImagesNavigatorType
    let useCase: CollectionImagesUseCaseType
    let collection: Collection
    let disposeBag = DisposeBag()
    
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
                // TODO: - NEXT_TASK
                print("For next task - navigator")
            })
            .mapToVoid()
        let collectionObservable = Observable<Collection>.create { (observer) in
            observer.onNext(self.collection)
            observer.onCompleted()
            return Disposables.create()
        }.asDriverOnErrorJustComplete()
        let isEmptyData = Driver.combineLatest(photos, loading)
            .filter { !$0.1 }
            .map { $0.0.isEmpty }
        input.toHomeScreenTrigger.asObservable().subscribe(onNext: {
            self.navigator.toHomeScreen()
            })
            .disposed(by: disposeBag)
        var arrRatio = [CGFloat]()
        let observableRelay = BehaviorRelay<[CGFloat]>(value: arrRatio)
        photos.asObservable().subscribe(onNext: { photos in
                arrRatio.removeAll()
                for photo in photos {
                    arrRatio.append(CGFloat(photo.width) / CGFloat(photo.height))
                }
                observableRelay.accept(arrRatio)
            })
            .disposed(by: disposeBag)
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItem,
            photos: photos,
            selectedPhoto: selectedPhoto,
            isEmptyData: isEmptyData,
            collection: collectionObservable,
            ratios: observableRelay
        )
    }
}
