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
}
