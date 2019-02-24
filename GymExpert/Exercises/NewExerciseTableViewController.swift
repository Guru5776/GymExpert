//
//  CreateWorkoutController.swift
//  GymExpert
//
//  Created by Admin on 1/11/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData

protocol NewExerciseControllerDelegate {
    func didAddExercise(exercise: Exercise)
    func didEditExercise(exercise: Exercise)
}

class NewExerciseTableViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    var dataGroup = ["Пресс", "Руки", "Спина", "Грудь", "Плечи", "Ноги", "Кардио", "Растяжка"]
    var dataLevel = ["Начинающий", "Средний", "Продвинутый", "Мастер"]
    
    var pickerGroup = UIPickerView()
    var pickerLevel = UIPickerView()
    var descriptionTextField = UITextView()
    
    var exercise: Exercise? {
        
        didSet {
            nameTextField.text = exercise?.name
            groupTextField.text = exercise?.groupLabel
            levelTextField.text = exercise?.levelLabel
            descriptionTextField.text = exercise?.descriptLabel
            
            if let image = exercise?.image {
                exerciseImageView.image = UIImage(data: image)
                setupCircularImageStyle()
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
        textField.placeholder = "Введите название упражнения"
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
        textField.placeholder = "Выберете группу упражнения"
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
        textField.placeholder = "Выберете уровень сложности"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = exercise == nil ? "Добавить упражнение" : "Изменить упражнение"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextField.text = "Введите описание"
        descriptionTextField.textColor = UIColor.lightGray
        descriptionTextField.font = UIFont(name: "verdana", size: 16)
        descriptionTextField.backgroundColor = UIColor.clear
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.returnKeyType = .done
        descriptionTextField.delegate = self
        pickerGroup.delegate = self
        pickerGroup.dataSource = self
        pickerLevel.delegate = self
        pickerLevel.dataSource = self
        groupTextField.inputView = pickerGroup
        levelTextField.inputView = pickerLevel
        
        setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(handleSave))
        
        view.backgroundColor = UIColor.darkBlue
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Введите описание" {
            textView.text = ""
        }
        textView.becomeFirstResponder()
        textView.textColor = UIColor.black
        textView.font = UIFont(name: "verdana", size: 16)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Введите описание"
        }
        textView.resignFirstResponder()
        textView.textColor = UIColor.black
        textView.font = UIFont(name: "verdana", size: 16)
    }
    
    @objc private func handleSave() {
        
        guard let exerciseName = nameTextField.text else { return }
        guard let exerciseGroup = groupTextField.text else { return }
        guard let exerciseLevel = levelTextField.text else { return }
        
        if exerciseName.isEmpty || exerciseGroup.isEmpty || exerciseLevel.isEmpty {
            showError(title: "Не все поля заполнены!", message: "Заполните все поля!")
            return
        }
        
        if exercise == nil {
            createExercise()
        } else {
            saveExerciseChanges()
        }
    }
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveExerciseChanges() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        exercise?.name = nameTextField.text
        exercise?.groupLabel = groupTextField.text
        exercise?.levelLabel = levelTextField.text
        exercise?.descriptLabel = descriptionTextField.text
        
        if let exerciseImage = exerciseImageView.image {
            let image = exerciseImage.jpegData(compressionQuality: 0.8)
            exercise?.image = image
        }
        do {
            try context.save()
            
            dismiss(animated: true, completion: {
                self.delegate?.didEditExercise(exercise: self.exercise!)
            })
            
        } catch let saveErr {
            print("Failed to save exercise changes", saveErr)
        }
    }
    
    private func createExercise() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let exercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context)
        
        exercise.setValue(nameTextField.text, forKey: "name")
        exercise.setValue(groupTextField.text, forKey: "groupLabel")
        exercise.setValue(levelTextField.text, forKey: "levelLabel")
        exercise.setValue(descriptionTextField.text, forKey: "descriptLabel")
        
        if let exerciseImage = exerciseImageView.image {
            let image = exerciseImage.jpegData(compressionQuality: 0.8)
            exercise.setValue(image, forKey: "image")
        }
        do {
            try context.save()
            
            dismiss(animated: true, completion: {
                self.delegate?.didAddExercise(exercise: exercise as! Exercise)
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
        lightBlueBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.addSubview(exerciseImageView)
        exerciseImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        exerciseImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        exerciseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exerciseImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        view.addSubview(groupLabel)
        groupLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        groupLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        groupLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        groupLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(groupTextField)
        groupTextField.leftAnchor.constraint(equalTo: groupLabel.rightAnchor).isActive = true
        groupTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        groupTextField.bottomAnchor.constraint(equalTo: groupLabel.bottomAnchor).isActive = true
        groupTextField.topAnchor.constraint(equalTo: groupLabel.topAnchor).isActive = true
        
        view.addSubview(levelLabel)
        levelLabel.topAnchor.constraint(equalTo: groupLabel.bottomAnchor).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        levelLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        levelLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(levelTextField)
        levelTextField.leftAnchor.constraint(equalTo: levelLabel.rightAnchor).isActive = true
        levelTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        levelTextField.bottomAnchor.constraint(equalTo: levelLabel.bottomAnchor).isActive = true
        levelTextField.topAnchor.constraint(equalTo: levelLabel.topAnchor).isActive = true
        
        view.addSubview(descriptionTextField)
        descriptionTextField.topAnchor.constraint(equalTo: levelTextField.bottomAnchor).isActive = true
        descriptionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        descriptionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextField.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -300).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
