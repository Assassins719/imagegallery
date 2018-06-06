//
//  ImageTableViewCell.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    weak var viewController:UIViewController!
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    var imageList:[Image]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initCollectionView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
