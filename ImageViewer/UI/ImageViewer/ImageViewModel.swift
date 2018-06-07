//
//  ImageViewModel.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class ImageViewModel {
    var databaseService = DatabaseService ()
    
    func isFavoriteImage(_ image:Image) -> Bool{
        return databaseService.isFavoriteImage(image)
    }
}
