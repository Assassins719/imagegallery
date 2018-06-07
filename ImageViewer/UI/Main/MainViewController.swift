//
//  MainViewController.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import ImageSlideshow
import GradientView

class MainViewController: UIViewController {

    // MARK: menu image outlet
    
    @IBOutlet weak var menuImageOutlet: UIImageView!
    
    // MARK: image slider outlet
    
    @IBOutlet weak var imageSlideOutlet: ImageSlideshow!
    
    @IBOutlet weak var imageGradientTopOutlet: UIView!
    @IBOutlet weak var imageGradientBottomOutlet: UIView!
    
    @IBOutlet weak var authorLabelOutlet: UILabel!
    @IBOutlet weak var imageTitleLabelOutlet: UILabel!
    
    // MARK: table view outlet
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    // MARK: other
    var viewModel : MainViewModel!
    
    var topImageList:[Image]!
    var imageSet:[[Image]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMenu()
        
        initViewModel()
        
        initImageSlider()
        
        initTableView()
    }
    
    @objc func menuImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if let revealVC = revealViewController() {
            revealVC.rearViewRevealWidth = self.view.frame.width
            revealVC.rearViewRevealOverdraw = 0
            revealVC.revealToggle(animated: true)
//            revealVC.rightViewRevealWidth = self.view.frame.width
//            revealVC.rightRevealToggle(animated: true)
            
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
            view.addGestureRecognizer(revealVC.tapGestureRecognizer())
        }
    }

    func initMenu(){
        let tapMenuImage_GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuImageTapped(tapGestureRecognizer:)))
        menuImageOutlet.isUserInteractionEnabled = true
        menuImageOutlet.addGestureRecognizer(tapMenuImage_GestureRecognizer)
    }
    
    func initViewModel() {
        self.topImageList = Assets.shared.topImageList
        self.imageSet = Assets.shared.imageSet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

