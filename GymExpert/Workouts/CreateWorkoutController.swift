//
//  CreateWorkoutController.swift
//  GymExpert
//
//  Created by Admin on 1/11/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData

protocol CreateWorkoutControllerDelegate {
    func didAddWorkout(workout: Workout)
    func didEditWorkot(workout: Workout)
}

class CreateWorkoutController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var workout: Workout? {
        
        didSet {
            nameTextField.text = workout?.name
            
            if let imageData = workout?.imageData {
                workoutImageView.image = UIImage(data: imageData)
                setupCircularImageStyle()
            }
        }
    }
    
    private func setupCircularImageStyle() {
        workoutImageView.layer.cornerRadius = workoutImageView.frame.width / 2
        workoutImageView.clipsToBounds = true
        workoutImageView.layer.borderColor = UIColor.darkBlue.cgColor
        workoutImageView.layer.borderWidth = 2
    }
    
    var delegate: CreateWorkoutControllerDelegate?
    
    lazy var workoutImageView: UIImageView = {
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            
            workoutImageView.image = editedImage
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            workoutImageView.image = originalImage
        }
        
        setupCircularImageStyle()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название программы"
        textField.translatesAutoresizingMaskIntoConstraints = false
        //        textField.keyboardType = .numberPad
        return textField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = workout == nil ? "Добавить программу" : "Изменить программу"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelButton()
        
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(handleSave))
        
        view.backgroundColor = UIColor.darkBlue
    }
    
    @objc private func handleSave() {
        
        guard let workoutName = nameTextField.text else { return }
        
        if workoutName.isEmpty{
            showError(title: "Не введено название", message: "Введите название программы!")
            return
        }
        
        if workout == nil {
            createWorkout()
        } else {
            saveWorkoutChanges()
        }
    }
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveWorkoutChanges() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        workout?.name = nameTextField.text
        
        if let workoutImage = workoutImageView.image {
            let imageData = workoutImage.jpegData(compressionQuality: 0.8)
            workout?.imageData = imageData
        }
        do {
            try context.save()
            
            dismiss(animated: true, completion: {
                self.delegate?.didEditWorkot(workout: self.workout!)
            })
            
        } catch let saveErr {
            print("Failed to save workout changes", saveErr)
        }
    }
    
    private func createWorkout() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let workout = NSEntityDescription.insertNewObject(forEntityName: "Workout", into: context)
        
        workout.setValue(nameTextField.text, forKey: "name")
        
        if let workoutImage = workoutImageView.image {
            let imageData = workoutImage.jpegData(compressionQuality: 0.8)
            workout.setValue(imageData, forKey: "imageData")
        }
        do {
            try context.save()
            
            dismiss(animated: true, completion: {
                self.delegate?.didAddWorkout(workout: workout as! Workout)
            })
            
        } catch let saveErr {
            print("Failed to save workout:", saveErr)
        }
    }
    
    private func setupUI() {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 158).isActive = true
        
        view.addSubview(workoutImageView)
        workoutImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        workoutImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        workoutImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        workoutImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: workoutImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
    }
}
