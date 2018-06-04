//
//  CollectionImage.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SQLite

class CollectionImage {
    var idCollection: Int64
    var idImage: Int64
    
    init(withRow row_item: Row) {
        idCollection = row_item[CollectionImage_Table.idCollection]
        idImage = row_item[CollectionImage_Table.idImage]
    }
    
    init(withMergedRow row_item: Row) {
        idCollection = row_item[CollectionImage_Table.CollectionImage[CollectionImage_Table.idCollection]]
        idImage = row_item[CollectionImage_Table.CollectionImage[CollectionImage_Table.idImage]]
        
        
    }
    
    var debug :String {
        return "\(idCollection) \(idImage)"
    }
    
}

class CollectionImage_Table {
    static let CollectionImage = Table("collection_image")
    
    static let idCollection = Expression<Int64>("idCollection")
    static let idImage = Expression<Int64>("idImage")
    
}

func tester_CollectionImage_Table() {
    do {
        let dd = try StoryDatabase.shared.db.prepare(CollectionImage_Table.CollectionImage)
        for ddItem in dd {
            let dde = CollectionImage(withRow: ddItem)
            print("dde: \(dde.debug)")
        }
    } catch {
        print("\(error)")
    }
}
