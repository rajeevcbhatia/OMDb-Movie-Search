//
//  ItemTableViewCell.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 24/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func loadDetails(item: OMDbItem) {
        
        imgView.sd_setImage(with: URL(string: item.posterUrlString ?? Constants.placeholderPosterURLString))
        nameLabel.text = item.title?.uppercased()
        typeLabel.text = item.type?.uppercased()
        
    }
}
