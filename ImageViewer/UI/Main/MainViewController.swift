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

    // image slider outlet
    
    @IBOutlet weak var imageSlideOutlet: ImageSlideshow!
    
    @IBOutlet weak var imageGradientTopOutlet: UIView!
    @IBOutlet weak var imageGradientBottomOutlet: UIView!
    
    @IBOutlet weak var authorLabelOutlet: UILabel!
    @IBOutlet weak var imageTitleLabelOutlet: UILabel!
    
    // image slider outlet -- end
    
    // table view outlet
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    // table view outlet -- end
    
    var viewModel : MainViewModel!
    var imageList:[Image]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
        
        initImageSlider()
        
        initTableView()
    }
    
    func initViewModel() {
        self.imageList = viewModel.getTopImageList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

