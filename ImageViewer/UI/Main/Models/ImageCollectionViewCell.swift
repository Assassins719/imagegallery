//
//  ImageCollectionViewCell.swift
//  ImageViewer
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var authorOutlet: UILabel!
    @IBOutlet weak var titleOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
