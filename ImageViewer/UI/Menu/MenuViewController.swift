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
    
    @IBOutlet weak var facebookImageOutlet: UIImageView!
    @IBOutlet weak var twiterImageOutlet: UIImageView!
    @IBOutlet weak var instagramImageOutlet: UIImageView!
    @IBOutlet weak var pintestImageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // init langualge buootn
        languageButtonOutlet.layer.cornerRadius = languageButtonOutlet.frame.height / 2
        initMenu()
        initLinkImage()
        
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
    
    func openURL(_ url:String) {
        guard let url = URL(string: url) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    @objc func facebookImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openURL("https://www.facebook.com")
    }
    
    @objc func twiterImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openURL("https://twitter.com")
    }
    
    @objc func instagramImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openURL("https://www.instagram.com")
    }
    
    @objc func pintestImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openURL("https://www.pinterest.com")
    }
    
    
    func initLinkImage() {
        let tapFacebookImage_GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(facebookImageTapped(tapGestureRecognizer:)))
        facebookImageOutlet.isUserInteractionEnabled = true
        facebookImageOutlet.addGestureRecognizer(tapFacebookImage_GestureRecognizer)
        
        let tapTwiterImage_GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(twiterImageTapped(tapGestureRecognizer:)))
        twiterImageOutlet.isUserInteractionEnabled = true
        twiterImageOutlet.addGestureRecognizer(tapTwiterImage_GestureRecognizer)
        
        let tapInstagramImage_GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(instagramImageTapped(tapGestureRecognizer:)))
        instagramImageOutlet.isUserInteractionEnabled = true
        instagramImageOutlet.addGestureRecognizer(tapInstagramImage_GestureRecognizer)
        
        let tapPintestImage_GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pintestImageTapped(tapGestureRecognizer:)))
        pintestImageOutlet.isUserInteractionEnabled = true
        pintestImageOutlet.addGestureRecognizer(tapPintestImage_GestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
