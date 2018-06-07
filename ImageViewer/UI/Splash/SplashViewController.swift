//
//  SplashViewController.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import RxSwift
import CocoaLumberjack
import NVActivityIndicatorView

class SplashViewController: UIViewController {

    @IBOutlet weak var loadingOutlet: NVActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    var viewModel:SplashViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViewModel() {
        viewModel.state
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { status in
                switch status {
                case .IDLE:
                    DDLogDebug("IDLE")
                case .GETTING_CATALOG:
                    DDLogDebug("GETTING_CATALOG")
                    self.loadingOutlet.color = UIColor.white
                    self.loadingOutlet.startAnimating()
                case .GETTING_CATALOG_ERROR:
                    
                    DDLogError("GETTING_CATALOG_ERROR")
                case .GETTING_CATALOG_SUCCESS:
                    DDLogDebug("GETTING_CATALOG_SUCCESS")
                    self.gotoMainPage()
                }
            }).disposed(by: disposeBag)
        viewModel.initImageAsset()
    }
    
    func gotoMainPage(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let catalogController = appDelegate.mainSwinjectStoryboard.instantiateViewController(withIdentifier: "vc_reveal")
            as! SWRevealViewController
        appDelegate.window.rootViewController = catalogController
    }
    
}
