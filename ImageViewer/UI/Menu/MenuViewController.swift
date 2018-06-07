//
//  MenuViewController.swift
//  ImageViewer
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var languageButtonOutlet: UIButton!
    
    @IBOutlet weak var closeImageOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // init langualge buootn
        languageButtonOutlet.layer.cornerRadius = languageButtonOutlet.frame.height / 2
        initMenu()
        
    }
    
    @objc func menuImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if let revealVC = revealViewController() {
//            revealVC.rearViewRevealWidth = self.view.frame.width
            revealVC.rightViewRevealWidth = self.view.frame.width
            revealVC.rightRevealToggle(animated: true)
            
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
            view.addGestureRecognizer(revealVC.tapGestureRecognizer())
        }
    }
    
    func initMenu(){
        let tapMenuImage_GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuImageTapped(tapGestureRecognizer:)))
        closeImageOutlet.isUserInteractionEnabled = true
        closeImageOutlet.addGestureRecognizer(tapMenuImage_GestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
