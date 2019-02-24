//
//  ExerciseDetailController.swift
//  GymExpert
//
//  Created by Admin on 1/18/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData
import SwiftyGif

protocol ExerciseDetailControllerDelegate {
    func didAddExercise(exercise: Exercise)
}

class ExerciseDetailController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var dataGroup = ["Пресс", "Руки", "Спина", "Грудь", "Плечи", "Ноги", "Кардио", "Растяжка"]
    var dataLevel = ["Начинающий", "Средний", "Продвинутый", "Мастер"]
    
    var pickerGroup = UIPickerView()
    var pickerLevel = UIPickerView()
    
    
    var exercise: Exercise? {
        
        didSet {
            nameTextField.text = exercise?.name
            groupTextField.text = exercise?.groupLabel
            levelTextField.text = exercise?.levelLabel
            descriptionLabel.text = exercise?.descriptLabel
            
            if let image = exercise?.image {
                exerciseImageView.image = UIImage(data: image)
            }
        }
    }
    
    private func setupCircularImageStyle() {
        exerciseImageView.layer.cornerRadius = exerciseImageView.frame.width / 2
        exerciseImageView.clipsToBounds = true
        exerciseImageView.layer.borderColor = UIColor.darkBlue.cgColor
        exerciseImageView.layer.borderWidth = 2
    }
    
    var delegate: NewExerciseControllerDelegate?
    
    lazy var exerciseImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()
    
    @objc private func handleSelectPhoto() {
        print("Trying to select photo...")
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerGroup { return dataGroup.count}
        if pickerView == pickerLevel { return dataLevel.count}
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerGroup {
            self.groupTextField.text = self.dataGroup[row]
        } else if pickerView == pickerLevel {
            self.levelTextField.text = self.dataLevel[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerGroup { return dataGroup[row]}
        if pickerView == pickerLevel { return dataLevel[row]}
        return ""
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            
            exerciseImageView.image = editedImage
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            exerciseImageView.image = originalImage
        }
        
        setupCircularImageStyle()
        
        dismiss(animated: true, completion: nil)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Упражнение"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название"
        textField.translatesAutoresizingMaskIntoConstraints = false
        //        textField.keyboardType = .numberPad
        return textField
    }()
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.text = "Группа"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let groupTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Выберете группу"
        textField.translatesAutoresizingMaskIntoConstraints = false
        //        textField.keyboardType = .numberPad
        return textField
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Уровень"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let levelTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Выберете уровень"
        textField.translatesAutoresizingMaskIntoConstraints = false
        //        textField.keyboardType = .numberPad
        return textField
    }()
    
    let descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UITextView = {
        let label = UITextView()
        label.text = "Введите описание"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "verdana", size: 16)
        //        textField.keyboardType = .numberPad
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = exercise?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerGroup.delegate = self
        pickerGroup.dataSource = self
        pickerLevel.delegate = self
        pickerLevel.dataSource = self
        groupTextField.inputView = pickerGroup
        levelTextField.inputView = pickerLevel
        
        setupUI()
        
        view.backgroundColor = UIColor.darkBlue
    }

    private func setupUI() {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightGrey
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.addSubview(exerciseImageView)
        exerciseImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        exerciseImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        exerciseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exerciseImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -300).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
