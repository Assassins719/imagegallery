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
        
        for item in self.topImageList {
            guard let imageSource = item.getImageSource() else {
                DDLogError("Cannot get imageSource")
                continue
            }
            imageSourceList.append(imageSource)
        }
        
        self.imageSlideOutlet.setImageInputs(imageSourceList)
        
        self.authorLabelOutlet.text = self.topImageList.first?.author
        self.imageTitleLabelOutlet.text = self.topImageList.first?.imageTitle
        
        
        self.imageSlideOutlet.currentPageChanged = { page in
            if let author = self.topImageList[page].author{
                self.authorLabelOutlet.fadeTransition(0.8)
                self.authorLabelOutlet.text = author
            }
            if let title = self.topImageList[page].imageTitle {
                self.imageTitleLabelOutlet.fadeTransition(0.8)
                self.imageTitleLabelOutlet.text = title
            }
        }
        initImageSliderTap()
//        imageSliderAutoPlay()
    }
    
    @objc func imageSliderTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let size = self.imageSlideOutlet.images.count
        if size == 0 { return }
        let current = self.imageSlideOutlet.currentPage
        let inputSource = self.imageSlideOutlet.images[current]
        
        let uiImageView = UIImageView()
        inputSource.load(to: uiImageView) { (uiimage) in
            guard let uiimage = uiimage else{
                return
            }
            let configuration = ImageViewerConfiguration { config in
                config.image = uiimage
            }
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let imageViewController = ImageViewerController(configuration:configuration)// appDelegate.mainSwinjectStoryboard.instantiateViewController(withIdentifier: "ImageViewerController")
//                as! ImageViewerController
//            imageViewController.configuration = configuration
            
            imageViewController.image_dbItem = self.topImageList[current]
            self.present(imageViewController, animated: true)
            
        }
    }
    
    func initImageSliderTap(){
        let tapImageSlider_GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSliderTapped(tapGestureRecognizer:)))
        imageSlideOutlet.isUserInteractionEnabled = true
        imageSlideOutlet.addGestureRecognizer(tapImageSlider_GestureRecognizer)
    }
    
    func imageSliderAutoPlay(){
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            self.imageSilderUpdate()
        })
        
    }
    
    private func imageSilderUpdate(){
        let size = self.imageSlideOutlet.images.count
        if size == 0 { return }
        let current = self.imageSlideOutlet.currentPage
        let newImageIndex = (current + 1) % size
        self.imageSlideOutlet.setCurrentPage(newImageIndex, animated: true)
    }
    
    func initGradient() {
        imageGradientTopOutlet.drawTopGradient()
        imageGradientBottomOutlet.drawBottomGradient()
    }
    
}
