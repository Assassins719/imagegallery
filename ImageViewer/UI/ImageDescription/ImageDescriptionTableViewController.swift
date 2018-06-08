//
//  ImageDescriptionTableViewController.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ImageDescriptionTableViewController: UITableViewController {
    var image_dbItem:Image!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 0
        case 1: return 50
        case 2: return self.view.frame.height - 50
//        case 3: return self.view.frame.height - 50 - 500
        default: return 60
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDescriptionTableViewCell", for: indexPath) as! ImageDescriptionTableViewCell
        switch indexPath.row {
        case 0: cell.layer.backgroundColor = UIColor.red.withAlphaComponent(0.1).cgColor
//            cell.layer.opacity = 0.01
        // UIColor.clear.cgColor
        case 1: cell.labelOutlet.text = image_dbItem.author
        case 2: cell.labelOutlet.text = image_dbItem.imageTitle
        default: break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.row == 0 {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
