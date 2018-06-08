//
//  MainViewController+tableview.swift
//  ImageViewer
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController : UITableViewDataSource {
    
    func initTableView(){
        self.tableViewOutlet.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabelOutlet.text = "Special collection, 1997-1998"
            break
        case 1:
            cell.titleLabelOutlet.text = "Special collection, 1999-2000"
            break
        case 2:
            cell.titleLabelOutlet.text = "Special collection, 2000-2001"
            break
        case 3:
            cell.titleLabelOutlet.text = "Special collection, 2001-2002"
            break
        case 4:
            cell.titleLabelOutlet.text = "Favorites"
            break
        default:break
        }
        
        cell.viewController = self
        
        cell.imageList = self.imageSet[indexPath.row]
        return cell
    }
}
