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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // init langualge buootn
        languageButtonOutlet.layer.cornerRadius = languageButtonOutlet.frame.height / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
