//
//  MainViewController+ImageSlide.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import ImageSlideshow
import GradientView
import CocoaLumberjack

extension MainViewController {
    
    override func viewDidLayoutSubviews() {
        initGradient()
    }
    
    func initImageSlider() {
        
        self.imageSlideOutlet.contentScaleMode = .scaleAspectFill
        
        var imageSourceList = [ImageSource]()
        
        for item in self.imageList {
            guard let imageSource = item.getImageSource() else {
                DDLogError("Cannot get imageSource")
                continue
            }
            imageSourceList.append(imageSource)
        }
        
        self.imageSlideOutlet.setImageInputs(imageSourceList)
        
        self.authorLabelOutlet.text = self.imageList.first?.author
        self.imageTitleLabelOutlet.text = self.imageList.first?.imageTitle
        
        
        self.imageSlideOutlet.currentPageChanged = { page in
            if let author = self.imageList[page].author{
                self.authorLabelOutlet.fadeTransition(0.8)
                self.authorLabelOutlet.text = author
            }
            if let title = self.imageList[page].imageTitle {
                self.imageTitleLabelOutlet.fadeTransition(0.8)
                self.imageTitleLabelOutlet.text = title
            }
            
        }
    }
    
    func initGradient(){
        imageGradientTopOutlet.drawTopGradient()
        imageGradientBottomOutlet.drawBottomGradient()
    }
    
}
