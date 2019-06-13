//
//  NewsDetailsVC.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit
import SDWebImage
class NewsDetailsVC: UIViewController {
    @IBOutlet weak var coverImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    @IBOutlet weak var descLabel : UILabel!
    var articleName = ""
    var date = ""
    var author = ""
    var desc = ""
    var cover : UIImage?
    var image_url = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.title = articleName
        titleLabel.text = articleName
        if image_url != ""{
            self.coverImage?.sd_setImage(with: URL(string:image_url), placeholderImage: UIImage(named: ""), options: SDWebImageOptions.refreshCached, progress: nil, completed: { (image, error, cache, url) in
                if error == nil {
                    self.coverImage?.image = image
                }
            })
        }else{
            coverImage.backgroundColor = UIColor.orange
        }
        
        dateLabel.text = date
        authorLabel.text = author
        descLabel.text = desc
        
    }
    
    
    @IBAction func backAction(_ sender : UIBarButtonItem){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarVC
        Switcher.navigateWithNavigationController(viewController: vc)
    }


}
