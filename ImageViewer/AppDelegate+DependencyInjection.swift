//
//  AppDelegate+DependencyInjection.swift
//  ImageViewer
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension AppDelegate {
    
    func registerServices() {
        // auth service and api
        diContainer.register(DatabaseService.self) { _ in
            let databaseService = DatabaseService()
            return databaseService
        }
    }
    
    func registerViewModels(){
        diContainer.register(MainViewModel.self) { r in
            let mainViewModel = MainViewModel()
            mainViewModel.databaseService = r.resolve(DatabaseService.self)
            return mainViewModel
        }
    }
    
    func registerViewControllers(){
        diContainer.storyboardInitCompleted(MainViewController.self) { r, c in
            c.viewModel = r.resolve(MainViewModel.self)
        }
    }
}
