//
//  CreateEmployeeController.swift
//  GymExpert
//
//  Created by Admin on 1/18/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var workout: Workout?
    
    var delegate: CreateEmployeeControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "введите название"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let sideLabel: UILabel = {
        let label = UILabel()
        label.text = "Подходы"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sideTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "введите количество подходов"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let repetitionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Повторения"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repetitionsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "введите количество повторений"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Добавить упражнение"
        
        setupCancelButton()
        
        view.backgroundColor = .darkBlue
        
        _ = setupLightBlueBackgroundView(height: 250)
        
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        guard let employeeName = nameTextField.text else { return }
        guard let employeeSide = sideTextField.text else { return }
        guard let employeeRepeat = repetitionsTextField.text else { return }
        guard let workout = self.workout else { return }
        
        if employeeName.isEmpty || employeeSide.isEmpty || employeeRepeat.isEmpty{
            showError(title: "Не все поля заполнены!", message: "Заполните все поля!")
            return
        }
        
        guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }
        
        let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName, employeeType: employeeType, workout: workout, employeeSide: employeeSide, employeeRepeat: employeeRepeat)
        if let error = tuple.1 {
            // is where you present an error modal of some kind
            // perhaps use a UIAlertController to show your error message
            print(error)
        } else {
            // creation success
            dismiss(animated: true, completion: {
                // we'll call the delegate somehow
                self.delegate?.didAddEmployee(employee: tuple.0!)
            })
        }
    }
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    let employeeTypeSegmentedControl: UISegmentedControl = {
//        let types = ["Пн.", "Вт.", "Ср.", "Чт.", "Пт.", "Суб.", "Вс."]
        
        let types = [
        EmployeeType.mondayEmployee.rawValue,
        EmployeeType.tuesdayEmployee.rawValue,
        EmployeeType.wednesdayEployee.rawValue,
        EmployeeType.thursdayEployee.rawValue,
        EmployeeType.fridayEployee.rawValue,
        EmployeeType.saturdayEployee.rawValue,
        EmployeeType.sundayEployee.rawValue
            
        ]
        
        
        
        let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.darkBlue
        return sc
    }()
    
    
    private func setupUI() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        view.addSubview(sideLabel)
        sideLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        sideLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        sideLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        sideLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(sideTextField)
        sideTextField.leftAnchor.constraint(equalTo: sideLabel.rightAnchor).isActive = true
        sideTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sideTextField.bottomAnchor.constraint(equalTo: sideLabel.bottomAnchor).isActive = true
        sideTextField.topAnchor.constraint(equalTo: sideLabel.topAnchor).isActive = true
        
        view.addSubview(repetitionsLabel)
        repetitionsLabel.topAnchor.constraint(equalTo: sideLabel.bottomAnchor).isActive = true
        repetitionsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        repetitionsLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        repetitionsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(repetitionsTextField)
        repetitionsTextField.leftAnchor.constraint(equalTo: repetitionsLabel.rightAnchor).isActive = true
        repetitionsTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        repetitionsTextField.bottomAnchor.constraint(equalTo: repetitionsLabel.bottomAnchor).isActive = true
        repetitionsTextField.topAnchor.constraint(equalTo: repetitionsLabel.topAnchor).isActive = true
        
        view.addSubview(employeeTypeSegmentedControl)
        employeeTypeSegmentedControl.topAnchor.constraint(equalTo: repetitionsLabel.bottomAnchor, constant: 0).isActive = true
        employeeTypeSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        employeeTypeSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        employeeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
}
