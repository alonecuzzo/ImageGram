//
//  AppDelegate.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: Property
    var window: UIWindow?


    //MARK: Method
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewModel = FeedViewModel()
        let feedViewController = FeedViewController(viewModel: viewModel)
        
        self.window?.rootViewController = feedViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
