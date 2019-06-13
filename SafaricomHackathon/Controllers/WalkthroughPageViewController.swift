//
//  WalkthroughPageViewController.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    
    var pageImages = ["","hand-1", "laptop", "soccer-ball-variant (1)"]
    var pageContent = ["Welcome to News API","Business News","Technology News","Sport News"]
    //var pageBackgroundImages = ["salvo_bac", "main_bac", "main_bac","main_bac"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // customizing navigation controller
        navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255, green: 106.0/255, blue: 0.0/255, alpha: 1.0)
        
        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward,
                               animated: true, completion: nil)
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController?
    {
        if index < 0 || index >= pageImages.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        if let pageContentViewController =
            storyboard?.instantiateViewController(withIdentifier:
                "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.content = pageContent[index]
            //pageContentViewController.background = pageBackgroundImages[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
        
    }
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated:
                true, completion: nil)
        }
    }
    
    
}
