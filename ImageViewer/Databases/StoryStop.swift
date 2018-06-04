//
//  Image.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

import SQLite

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
    
    init(withRow story_item: Row) {
        idImage = story_item[Image_Table.idImage]
        idAuthor = story_item[Image_Table.idAuthor]
        
        author = story_item[Image_Table.author]
        imageTitle = story_item[Image_Table.imageTitle]
        
        wImg = story_item[Image_Table.wImg]
        hImg = story_item[Image_Table.hImg]
        wImgThumb = story_item[Image_Table.wImgThumb]
        hImgThumb = story_item[Image_Table.hImgThumb]
        
        imageFileName = story_item[Image_Table.imageFileName]
        imageThumbFileName = story_item[Image_Table.imageThumbFileName]
        
    }
    
    init(withMergedRow story_item: Row) {
        idImage = story_item[Image_Table.Image[Image_Table.idImage]]
        idAuthor = story_item[Image_Table.Image[Image_Table.idAuthor]]
        
        author = story_item[Image_Table.Image[Image_Table.author]]
        imageTitle = story_item[Image_Table.Image[Image_Table.imageTitle]]
        
        wImg = story_item[Image_Table.Image[Image_Table.wImg]]
        hImg = story_item[Image_Table.Image[Image_Table.hImg]]
        wImgThumb = story_item[Image_Table.Image[Image_Table.wImgThumb]]
        hImgThumb = story_item[Image_Table.Image[Image_Table.hImgThumb]]
        
        imageFileName = story_item[Image_Table.Image[Image_Table.imageFileName]]
        imageThumbFileName = story_item[Image_Table.Image[Image_Table.imageThumbFileName]]
        
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

func tester1_Image_Table() {
    do {
        let dd = try StoryDatabase.shared.db.prepare(Image_Table.Image)
        for ddItem in dd {
            let dde = Image(withRow: ddItem)
            print("dde: \(dde)")
        }
    } catch {
        print("\(error)")
    }
}
