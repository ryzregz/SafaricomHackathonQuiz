//
//  WalkthroughContentViewController.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    var background = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // customizing navigation controller
        navigationController?.navigationBar.barTintColor = Config.sharedManager.mainColor
        pageControl.currentPage = index
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        backgroundImageView.image = UIImage(named: background)
        if index == 0{
            contentLabel.textColor = .white
        }else{
            contentLabel.textColor = .black
        }
        switch index {
        case 0...1: forwardButton.setTitle("Next", for: .normal)
        case 2: forwardButton.setTitle("Done", for: .normal)
        default: break
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        switch index {
        case 0...1:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            let loginViewController =  storyboard?.instantiateViewController(withIdentifier: "MainTabBar")
                as! MainTabBarVC
            present(loginViewController, animated: true, completion: nil)
        default: break
        }
        
    }
    
    
    @IBAction func toLogin(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        let loginViewController =  storyboard?.instantiateViewController(withIdentifier: "MainTabBar")
            as! MainTabBarVC
        present(loginViewController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
}
