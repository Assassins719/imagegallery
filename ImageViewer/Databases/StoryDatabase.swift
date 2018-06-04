//
//  StoryDatabase.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

import SQLite

class StoryDatabase {
    static let shared = StoryDatabase()
    
    static let NAME = "temp_StoryDatabase"
    static let VERSION = 1
    
    var db: Connection!
    
    init() {
        do {
            // TODO: need a helper function to reload database dynamically based on selected story
            let dbURL = Bundle.main.url(forResource: "img_vwr_db", withExtension: "sqlite")
            db = try Connection((dbURL?.absoluteString)!)
        } catch {
            print("Error \(error) occurred while trying to load SQLite database for story")
            fatalError()
        }
    }
}
