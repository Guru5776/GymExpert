//
//  ExerciseCell.swift
//  GymExpert
//
//  Created by Admin on 1/17/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {
    
    var exercise: Exercise? {
        didSet {
            
            nameLabel.text = exercise?.name
            groupLabel.text = exercise?.groupLabel
            levelLabel.text = exercise?.levelLabel
            descriptionLabel.text = exercise?.descriptLabel
            
            if let image = exercise?.image {
                exerciseImageView.image = UIImage(data: image)
            }
        }
    }
    
    let exerciseImageView: UIImageView = {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Exercise name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.text = "Exercise group"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Exercise level"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Exercise descript"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.tealColor
        
        addSubview(exerciseImageView)
        exerciseImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        exerciseImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        exerciseImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        exerciseImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: exerciseImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: exerciseImageView.topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        addSubview(groupLabel)
        groupLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 20).isActive = true
        groupLabel.leftAnchor.constraint(equalTo: exerciseImageView.rightAnchor, constant: 8).isActive = true
        
        addSubview(levelLabel)
        levelLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 40).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: exerciseImageView.rightAnchor, constant: 8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
