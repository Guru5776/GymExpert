//
//  SampleDetailTableViewCell.swift
//  GymExpert
//
//  Created by Admin on 12/21/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class SampleDetailTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
