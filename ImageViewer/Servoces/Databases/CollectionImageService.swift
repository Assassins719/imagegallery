//
//  CollectionImageService.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SQLite
import CocoaLumberjack

class CollectionImageService {
    func getCollectionImageList(byId idCollection:Int64) -> [CollectionImage]! {
        
        let query = CollectionImage_Table.CollectionImage.filter(CollectionImage_Table.idCollection == idCollection)
        
        do {
            var arr_result = [CollectionImage]()
            for item in try StoryDatabase.shared.db.prepare(query) {
                let obj = CollectionImage(withRow: item)
                arr_result.append(obj)
            }
            return arr_result
        } catch {
            DDLogError("\(error)")
        }
        return nil
    }
    
    func addCollectionImage(id idCollection:Int64, idImage: Int64){
         let query = CollectionImage_Table.CollectionImage
            .insert(
                CollectionImage_Table.idCollection <- idCollection,
                CollectionImage_Table.idImage <- idImage
                )
        do {
            _ = try StoryDatabase.shared.db.run(query)
        }catch{
            DDLogError(error.localizedDescription)
        }
    }
    
    func removeCollectionImage(id idCollection:Int64, idImage: Int64){
        let query = CollectionImage_Table.CollectionImage
            .filter(
                CollectionImage_Table.idCollection == idCollection &&
                CollectionImage_Table.idImage == idImage
        )
        
        
        _ = try! StoryDatabase.shared.db.run(query.delete())
    }
}
