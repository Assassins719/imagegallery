//
//  AppDelegate.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - AppDelegate fields
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - dependency injection fields
    
    let diContainer = Container()
    var mainSwinjectStoryboard: SwinjectStoryboard!
    
    override init() {
        super.init()
        
        mainSwinjectStoryboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: diContainer)
        
        registerServices()
        registerViewModels()
        registerViewControllers()
        
        NSSetUncaughtExceptionHandler { exception in
            DDLogError("Uncaught exception [\(exception)] occurred")
            DDLogError("Uncaught exception's stack trace:\n\(exception.callStackSymbols)")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window.makeKeyAndVisible()
        window.rootViewController = mainSwinjectStoryboard.instantiateInitialViewController()
        
        initLogging()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Logging configuration
    
    private func initLogging() {
        // log to Xcode console
        DDTTYLogger.sharedInstance.logFormatter = LogFormatter()
        DDLog.add(DDTTYLogger.sharedInstance)
        
        // log to Apple System Logs
        // DDASLLogger.sharedInstance.logFormatter = LogFormatter()
        // DDLog.add(DDASLLogger.sharedInstance)
    }

}

// MARK: State restoration

extension AppDelegate {
    func application(_: UIApplication, shouldSaveApplicationState _: NSCoder) -> Bool {
        return true
    }
    
    func application(_: UIApplication, shouldRestoreApplicationState _: NSCoder) -> Bool {
        return true
    }
}