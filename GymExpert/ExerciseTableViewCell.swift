//
//  ExerciseTableViewCell.swift
//  GymExpert
//
//  Created by Admin on 10/17/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
