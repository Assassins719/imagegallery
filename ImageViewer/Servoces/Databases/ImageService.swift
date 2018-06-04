//
//  ImageService.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SQLite

class ImageService {
    func getImageList() -> [Image]! {
        let query = Image_Table.Image
        
        do {
            var arr_result = [Image]()
            for item in try StoryDatabase.shared.db.prepare(query) {
                let obj = Image(withRow: item)
                arr_result.append(obj)
            }
            return arr_result
        } catch {
            print("\(error)")
        }
        return nil
    }
    
    func getImage(byId idImage:Int64) -> Image! {
        let query = Image_Table.Image.filter(Image_Table.idImage == idImage).limit(1)
        
        do {
            guard let row_item = try StoryDatabase.shared.db.pluck(query) else {
                return nil
            }
            return Image(withRow: row_item)
        } catch {
            print("\(error)")
        }
        return nil
    }
}
