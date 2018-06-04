//
//  collection.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SQLite

class Collection {
    var idCollection: Int64
    var collectionName: String!
    
    init(withRow row_item: Row) {
        idCollection = row_item[Collection_Table.idCollection]
        collectionName = row_item[Collection_Table.collectionName]
    }
    
    init(withMergedRow row_item: Row) {
        idCollection = row_item[Collection_Table.Collection[Collection_Table.idCollection]]
        collectionName = row_item[Collection_Table.Collection[Collection_Table.collectionName]]
        
        
    }
    
    var debug :String {
        return "\(idCollection) \(collectionName)"
    }
    
}

class Collection_Table {
    static let Collection = Table("collection")
    
    static let idCollection = Expression<Int64>("idCollection")
    static let collectionName = Expression<String?>("collectionName")
    
}

func tester_Collection_Table() {
    do {
        let dd = try StoryDatabase.shared.db.prepare(Collection_Table.Collection)
        for ddItem in dd {
            let dde = Collection(withRow: ddItem)
            print("dde: \(dde.debug)")
        }
    } catch {
        print("\(error)")
    }
}
