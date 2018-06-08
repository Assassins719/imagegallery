//
//  SplashViewModel.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import RxSwift
import CocoaLumberjack

class SplashViewModel {
    
    var databaseService : DatabaseService!
    
    enum STATE: Int {
        case IDLE = 0
        case GETTING_CATALOG = 1
        case GETTING_CATALOG_ERROR = 2
        case GETTING_CATALOG_SUCCESS = 3
    }
    
    
    var state: BehaviorSubject<STATE> = BehaviorSubject<STATE>(value: STATE.IDLE)
    
    func getTopImageList() -> Single<[Image]?>{
        return Single<[Image]?>.create { single in
            guard let imageList = self.databaseService.getTopImageList() else {
                fatalError()
            }
            single(.success(imageList))
            return Disposables.create()
        }
    }
    
    func getFavoritesImageList() -> [Image]! {
        guard let imageList = databaseService.getFavoritesImageList() else {
            return nil
        }
        if imageList.count == 0 {
            return nil
        }
        return imageList
    }
    
    func getSpecialImageList() -> [[Image]] {
        return databaseService.getSpecialImageList()
    }
    
    func getImageList() -> Single<[[Image]]> {
        return Single<[[Image]]>.create { single in
            var imageSet = self.getSpecialImageList()
            if let favoritesImageList = self.getFavoritesImageList() {
//                for item in favoritesImageList {
//                    guard let _ = item.getUIImage() else {
//                        DDLogError("Cannot get image")
//                        continue
//                    }
//                }
                imageSet.append(favoritesImageList)
            }
            
            single(.success(imageSet))
            return Disposables.create()
        }
    }
    
    private func initImageList(){
        _ = getImageList()
            .asObservable()
            .subscribe(onNext: {imageSet in
                for itemList in imageSet {
                    for item in itemList {
                        guard let _ = item.getUIImage() else {
                            DDLogError("Cannot get image")
                            continue
                        }
                    }
                    
                }
                Assets.shared.imageSet = imageSet
                self.state.onNext(.GETTING_CATALOG_SUCCESS)
            })
    }
    
    private func initTopImage(){
        _ = getTopImageList()
            .asObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: {imageList in
                guard let imageList = imageList else {
                    return
                }
                for item in imageList {
                    guard let _ = item.getUIImage() else {
                        DDLogError("Cannot get image")
                        continue
                    }
                }
                Assets.shared.topImageList = imageList
                self.initImageList()
            })
    }
    
    func initImageAsset(){
        self.state.onNext(.GETTING_CATALOG)
        initTopImage()
    }
}
