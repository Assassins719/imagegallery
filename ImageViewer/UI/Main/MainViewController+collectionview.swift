//
//  MainViewController+collectionview.swift
//  ImageViewer
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Foundation
//import SimpleImageViewer

extension MainViewController {
    func initCollectionView(){
        self.collectionViewOutlet.dataSource = self
        self.collectionViewOutlet.delegate = self
    }
}

extension MainViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        
        let configuration = ImageViewerConfiguration { config in
            config.image = cell.imageView.image
        }
        
        present(ImageViewerController(configuration: configuration), animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImageCollectionHeaderViewCell", for: indexPath) as! HeaderCollectionReusableView
        headerView.titleLabelOutlet.text = "header label"
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = self.imageList[indexPath.row].getUIImage()
        return cell
    }
    
}

extension MainViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 150.0)
    }
}

