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
                diContainer.register(SplashViewModel.self) { r in
                    let splashViewModel = SplashViewModel()
                    splashViewModel.databaseService = r.resolve(DatabaseService.self)
                    return splashViewModel
                }
        diContainer.register(MainViewModel.self) { r in
            let mainViewModel = MainViewModel()
            return mainViewModel
        }
        
//        diContainer.register(ImageViewModel.self) { r in
//            let imageViewModel = ImageViewModel()
//            imageViewModel.databaseService = r.resolve(DatabaseService.self)
//            return imageViewModel
//        }
        
    }
    
    func registerViewControllers(){
        diContainer.storyboardInitCompleted(SplashViewController.self) { r, c in
            c.viewModel = r.resolve(SplashViewModel.self)
        }
        diContainer.storyboardInitCompleted(MainViewController.self) { r, c in
            c.viewModel = r.resolve(MainViewModel.self)
        }
//        diContainer.storyboardInitCompleted(ImageViewerController.self) { r, c in
//            c.viewModel = r.resolve(ImageViewModel.self)
//        }
        
    }
}
