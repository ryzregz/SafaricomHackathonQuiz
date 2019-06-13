//
//  CategoryCell.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit
protocol CategoryDelegate : NSObjectProtocol{
    func categoryClicked(indexPath: IndexPath)
}
class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryTitleBtn : UIButton!
    weak var delegate:CategoryDelegate?
    
    public var indexPath:IndexPath!
    
    func configureCellWith(source : Source){
        categoryTitleBtn.setTitle(source.category,for: .normal)
    }
    
    @IBAction func laodArticleByCategoryAction(_ sender: UIButton) {
        if let delegate = self.delegate{
            delegate.categoryClicked(indexPath: indexPath)
        }
    }
}
