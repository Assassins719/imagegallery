//
//  MainViewModel.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class MainViewModel {
    var databaseService : DatabaseService!
    
    func getTopImageList() -> [Image]!{
        // guard let imageList = databaseService.getTopImageList() else {
        //     fatalError()
        // }
         guard let imageList = databaseService.imageService.getImageList() else {
             fatalError()
         }
        
        for item in imageList {
            print(item.debug)
        }
        return imageList
    }
}
