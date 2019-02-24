//
//  ExerciseDetailTableViewCell.swift
//  GymExpert
//
//  Created by Admin on 10/18/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class ExerciseDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
