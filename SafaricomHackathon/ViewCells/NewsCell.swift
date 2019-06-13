//
//  NewsCell.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit
import SDWebImage
class NewsCell: UITableViewCell {
    @IBOutlet weak var coverImage : UIImageView!
    @IBOutlet weak var newsTitle : UILabel!
    @IBOutlet weak var newDate : UILabel!
    @IBOutlet weak var newDesc : UILabel!
    
    func configureCellWith(article : Article){
        newsTitle.text = article.title
        newDate.text = article.publishedAt
        newDesc.text = article.description
        if article.urlToImage != ""{
            self.coverImage?.sd_setImage(with: URL(string: article.urlToImage!), placeholderImage: UIImage(named: ""), options: SDWebImageOptions.refreshCached, progress: nil, completed: { (image, error, cache, url) in
                if error == nil {
                    self.coverImage?.image = image
                }
            })
        }else{
            coverImage.backgroundColor = UIColor.orange
        }
        
    }
   

}
