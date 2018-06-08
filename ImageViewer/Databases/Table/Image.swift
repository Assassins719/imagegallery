//
//  Image.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import SQLite
import CocoaLumberjack
import ImageSlideshow

class Image {
    var idImage: Int64
    var idAuthor: Int64
    
    var author: String!
    var imageTitle: String!
    
    var wImg: Int!
    var hImg: Int!
    var wImgThumb: Int!
    var hImgThumb: Int!
    
    var imageFileName: String!
    var imageThumbFileName: String!
    
    // [MARK] temp variable for ui update
    
    var uiImage:UIImage!
    var imageSource:ImageSource!
    
    // [MARK] temp variable for ui update -- end
    
    init(withRow row_item: Row) {
        idImage = row_item[Image_Table.idImage]
        idAuthor = row_item[Image_Table.idAuthor]
        
        author = row_item[Image_Table.author]
        imageTitle = row_item[Image_Table.imageTitle]
        
        wImg = row_item[Image_Table.wImg]
        hImg = row_item[Image_Table.hImg]
        wImgThumb = row_item[Image_Table.wImgThumb]
        hImgThumb = row_item[Image_Table.hImgThumb]
        
        imageFileName = row_item[Image_Table.imageFileName]
        imageThumbFileName = row_item[Image_Table.imageThumbFileName]
        
    }
    
    init(withMergedRow row_item: Row) {
        idImage = row_item[Image_Table.Image[Image_Table.idImage]]
        idAuthor = row_item[Image_Table.Image[Image_Table.idAuthor]]
        
        author = row_item[Image_Table.Image[Image_Table.author]]
        imageTitle = row_item[Image_Table.Image[Image_Table.imageTitle]]
        
        wImg = row_item[Image_Table.Image[Image_Table.wImg]]
        hImg = row_item[Image_Table.Image[Image_Table.hImg]]
        wImgThumb = row_item[Image_Table.Image[Image_Table.wImgThumb]]
        hImgThumb = row_item[Image_Table.Image[Image_Table.hImgThumb]]
        
        imageFileName = row_item[Image_Table.Image[Image_Table.imageFileName]]
        imageThumbFileName = row_item[Image_Table.Image[Image_Table.imageThumbFileName]]
    }
    
    func getUIImage() -> UIImage! {
        if self.uiImage == nil {
            guard var filename = self.imageFileName else{
                return nil
            }
            guard let uiImage = UIImage(named: filename, in: Bundle(for: type(of: self)), compatibleWith: nil) else{
                DDLogError("uiImage else")
                return nil
            }
            self.uiImage = uiImage
            return self.uiImage
        }
        return self.uiImage
    }
    
    func getImageSource() -> ImageSource!{
        guard let ui_image = getUIImage() else{
            return nil
        }
        return ImageSource(image:ui_image)
    }
    
    var debug :String {
        return "\(idImage) \(author) \(wImg) \(imageFileName)"
    }
    
}

class Image_Table {
    static let Image = Table("image")
    
    static let idImage = Expression<Int64>("idImage")
    static let idAuthor = Expression<Int64>("idAuthor")
    static let author = Expression<String?>("author")
    static let imageTitle = Expression<String?>("imageTitle")
    
    static let wImg = Expression<Int>("wImg")
    static let hImg = Expression<Int>("hImg")
    
    static let wImgThumb = Expression<Int>("wImgThumb")
    static let hImgThumb = Expression<Int>("hImgThumb")
    
    static let imageFileName = Expression<String?>("imageFileName")
    static let imageThumbFileName = Expression<String?>("imageThumbFileName")
    
}

func tester_Image_Table() {
    do {
        let dd = try StoryDatabase.shared.db.prepare(Image_Table.Image)
        for ddItem in dd {
            let dde = Image(withRow: ddItem)
            print("dde: \(dde.debug)")
        }
    } catch {
        print("\(error)")
    }
}
