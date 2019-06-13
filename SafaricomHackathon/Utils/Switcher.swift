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
    
    static func navigateWithNavigationController(viewController: UIViewController){
        let rootVC = UINavigationController(rootViewController: viewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
