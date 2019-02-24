//
//  WorkoutCell.swift
//  GymExpert
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
    
    var workout: Workout? {
        didSet {
            
            nameLabel.text = workout?.name
            
            if let imageData = workout?.imageData {
                workoutImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    let workoutImageView: UIImageView = {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Workout name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.tealColor
        
        addSubview(workoutImageView)
        workoutImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        workoutImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        workoutImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        workoutImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: workoutImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
