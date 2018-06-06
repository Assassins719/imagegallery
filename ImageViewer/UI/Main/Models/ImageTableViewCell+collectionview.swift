//
//  ImageTableViewCell+collectionview.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
extension ImageTableViewCell :UICollectionViewDelegate,UICollectionViewDataSource {
    
    func initCollectionView(){
        self.collectionViewOutlet.dataSource = self
        self.collectionViewOutlet.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = self.imageList[indexPath.row].getUIImage()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        
        let configuration = ImageViewerConfiguration { config in
            config.imageView = cell.imageView
        }
        
        viewController.present(ImageViewerController(configuration: configuration), animated: true)
    }

 
}

//extension ImageTableViewCell:UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        self.frame.width
//        return CGSize(width: 150.0, height: 180.0)
//    }
//}
