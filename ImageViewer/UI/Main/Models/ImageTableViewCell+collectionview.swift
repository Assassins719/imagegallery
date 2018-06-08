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
        if let image =  self.imageList[indexPath.row].getUIImage(){
            cell.imageView.image = image
        }
        cell.titleOutlet.text = self.imageList[indexPath.row].imageTitle
        cell.authorOutlet.text = self.imageList[indexPath.row].author
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        
        let configuration = ImageViewerConfiguration { config in
            config.imageView = cell.imageView
        }
        
        //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let imageViewController = ImageViewerController(configuration:configuration)// appDelegate.mainSwinjectStoryboard.instantiateViewController(withIdentifier: "ImageViewerController")
        //                as! ImageViewerController
        //            imageViewController.configuration = configuration

        
        imageViewController.image_dbItem = self.imageList[indexPath.row]
        viewController.present(imageViewController, animated: true)
    }
    
}

//extension ImageTableViewCell:UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        self.frame.width
//        return CGSize(width: 150.0, height: 180.0)
//    }
//}
