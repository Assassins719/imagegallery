//
//  Assets.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import RxSwift
import CocoaLumberjack

class Assets {
    static let shared = Assets()
    
    let databaseService = DatabaseService()
    let updated: BehaviorSubject<Bool?> = BehaviorSubject<Bool?>(value: nil)
    
    var topImageList:[Image]!
    var imageSet:[[Image]]!
//    var favoriteImageList:[Image]!
    
    
    func refresh() -> Bool {
        DispatchQueue.global(qos: .background).async {
//        return Completable.create { completable in
            guard let favoritesImageList = self.databaseService.getFavoritesImageList() else {
                if Assets.shared.imageSet.count == 5 {
                   Assets.shared.imageSet.removeLast()
                }
                
                self.updated.onNext(false)
                return
            }
            for item in favoritesImageList {
                guard let _ = item.getUIImage() else {
                    DDLogError("Cannot get image")
                    continue
                }
            }
            
            if Assets.shared.imageSet.count == 5 {
                Assets.shared.imageSet[4] = favoritesImageList
            } else if Assets.shared.imageSet.count == 4 {
                Assets.shared.imageSet.append( favoritesImageList )
            }else{
                fatalError()
            }
            
//            completable(.completed)
            self.updated.onNext(true)
//            return Disposables.create()
        }
//        }
        return true
    }
}
