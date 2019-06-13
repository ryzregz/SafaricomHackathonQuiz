//
//  SourceCell.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {
    @IBOutlet weak var nameButton : UIButton!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var descLabel : UILabel!
    
    func configureCellWith(source : Source){
        nameButton.setTitle("\(source.name.prefix(1))", for: .normal)
        nameLabel.text = source.name
        descLabel.text = source.description
    }

}
