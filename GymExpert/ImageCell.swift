//
//  ImageCell.swift
//  GymExpert
//
//  Created by Admin on 11/28/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

