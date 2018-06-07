//
//  DatabaseService.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SQLite

class DatabaseService {
    enum CollectionName:Int64 {
        case TopSilder = 0
        case Favorites = 1
        case SpecialCollection1997_1998 = 20001
        case SpecialCollection1999_2000 = 20002
        case SpecialCollection2000_2001 = 20003
        case SpecialCollection2001_2002 = 20004
    }
 
    let collectionImageService = CollectionImageService()
    let imageService = ImageService()
    
    func getTopImageList() -> [Image]!{
        guard let collectionImageList = collectionImageService.getCollectionImageList(byId: CollectionName.TopSilder.rawValue) else{
            return nil
        }
        var list_image = [Image]()
        for item in collectionImageList {
            guard let image = imageService.getImage(byId: item.idImage) else{
                continue
            }
            list_image.append(image)
        }
        return list_image
    }
    
    func getFavoritesImageList() -> [Image]!{
        guard let collectionImageList = collectionImageService.getCollectionImageList(byId: CollectionName.Favorites.rawValue) else{
            return nil
        }
        var list_image = [Image]()
        for item in collectionImageList {
            guard let image = imageService.getImage(byId: item.idImage) else{
                continue
            }
            list_image.append(image)
        }
        return list_image
    }
    
    private func getImageList(byId collectionId:Int64)->[Image]!{
        guard let collectionImageList = collectionImageService.getCollectionImageList(byId: collectionId) else{
            return nil
        }
        var list_image = [Image]()
        for item in collectionImageList {
            guard let image = imageService.getImage(byId: item.idImage) else{
                continue
            }
            list_image.append(image)
        }
        return list_image
    }
    
    func getSpecialImageList() -> [[Image]]{
        var imageSet = [[Image]]()
        if let image1 = getImageList(byId:CollectionName.SpecialCollection1997_1998.rawValue) {
            imageSet.append(image1)
        }
        if let image2 = getImageList(byId:CollectionName.SpecialCollection1999_2000.rawValue) {
            imageSet.append(image2)
        }
        if let image3 = getImageList(byId:CollectionName.SpecialCollection2000_2001.rawValue) {
            imageSet.append(image3)
        }
        if let image4 = getImageList(byId:CollectionName.SpecialCollection2001_2002.rawValue) {
            imageSet.append(image4)
        }
        
        return imageSet
    }
    
    func isFavoriteImage(_ image:Image) -> Bool {
        guard let collectionImageList = collectionImageService.getCollectionImageList(byId: CollectionName.Favorites.rawValue) else{
            return false
        }
        for item in collectionImageList {
            if item.idImage == image.idImage {
                return true
            }
        }
        return false
    }
    
    func changeFavoriteImage(_ image:Image, _ checked:Bool){
        if checked {
            if isFavoriteImage(image) {
                return
            }
            collectionImageService.addCollectionImage(id: CollectionName.Favorites.rawValue, idImage: image.idImage)
        } else{
            if !isFavoriteImage(image) {
                return
            }
            collectionImageService.removeCollectionImage(id: CollectionName.Favorites.rawValue, idImage: image.idImage)
        }
    }
}
