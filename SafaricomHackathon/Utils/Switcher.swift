//
//  Switcher.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
import UIKit
class Switcher{
    

   
static func updateRootVC(){
    var rootVC : UIViewController?
    if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
    let mainVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarVC
          rootVC = UINavigationController(rootViewController: mainVC)
    }else{
    rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WalkthroughController")as? WalkthroughPageViewController
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = rootVC
    }
    
    static func navigateWithNavigationController(viewController: UIViewController){
        let rootVC = UINavigationController(rootViewController: viewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    static func navigate(viewController: UIViewController?){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = viewController
    }
}
