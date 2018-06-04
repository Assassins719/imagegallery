//
//  String.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
extension String {
    
    var fileName : String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    var fileExtension : String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}
