//
//  CreateSampleController.swift
//  GymExpert
//
//  Created by Admin on 1/13/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData

protocol CreateSampleControllerDelegate {
    func didAddSample(sample: Sample)
    func didEditSample(sample: Sample)
}
private var datePicker: UIDatePicker?

class CreateSampleController: UIViewController {
    
    var sample: Sample? {
        
        didSet {
            dateTextField.text = sample?.dataLabel
            rostTextField.text = sample?.rostSmLabel
            vesTextField.text = sample?.vesSmLabel
            shejaTextField.text = sample?.shejaSmLabel
            grudTextField.text = sample?.grudSmLabel
            talijaTextField.text = sample?.talijaSmLabel
            bedraTextField.text = sample?.bedraSmLabel
            bicepsSlevaTextField.text = sample?.bicepsSlevaSmLabel
            bicepsSpravaTextField.text = sample?.bicepsSpravaSmLabel
            bedroSlevaTextField.text = sample?.bedroSlevaSmLabel
            bedroSpravaTextField.text = sample?.bedroSpravaSmLabel
            ikraSlevaTextField.text = sample?.ikraSlevaSmLabel
            ikraSpravaTextField.text = sample?.ikraSpravaSmLabel
        }
        
    }
    
    // not tightly-coupled
    var delegate: CreateSampleControllerDelegate?
    
    //    var companiesController: CompaniesController?
    let kgLabel:UILabel = {
        let label = UILabel()
        label.text = "кг"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let smLabel:UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите дату"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let vesSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Вес"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let vesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите вес"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let rostSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Рост"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rostTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите рост"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let shejaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Шея"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shejaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите шею"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smShejaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let grudSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Грудь"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let grudTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите грудь"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smGrudLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let talijaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Талия"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let talijaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите талию"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smTalijaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bedraSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Бедра"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bedraTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите бедра"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smBedraLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bicepsSlevaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Бицепс(слева)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bicepsSlevaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите бицепс"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smBicepsSlevaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bicepsSpravaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Бицепс(справа)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bicepsSpravaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите бицепс"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smBicepsSpravaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bedroSlevaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Бедро(слева)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bedroSlevaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите бедро"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smBedroSlevaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bedroSpravaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Бедро(справа)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bedroSpravaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите бедро"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smBedroSpravaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ikraSlevaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Икра(слева)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ikraSlevaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите икру"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smIkraSlevaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ikraSpravaSmLabel: UILabel = {
        let label = UILabel()
        label.text = "Икра(справа)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ikraSpravaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите икру"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let smIkraSpravaLabel: UILabel = {
        let label = UILabel()
        label.text = "см"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = sample == nil ? "Добавить замеры" : "Изменить замеры"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(handleSave))
        
        view.backgroundColor = UIColor.darkBlue
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(CreateSampleController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateSampleController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        //        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        //        view.endEditing(true)
    }
    
    
    @objc private func handleSave() {
        if sample == nil {
            createSample()
        } else {
            saveSampleChanges()
        }
        
        guard let dateText = dateTextField.text else {return}
        
        print(dateText)
    }
    
    private func saveSampleChanges() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        sample?.dataLabel = dateTextField.text
        sample?.rostSmLabel = rostTextField.text
        sample?.vesSmLabel = vesTextField.text
        sample?.shejaSmLabel = shejaTextField.text
        sample?.grudSmLabel = grudTextField.text
        sample?.talijaSmLabel = talijaTextField.text
        sample?.bedraSmLabel = bedraTextField.text
        sample?.bicepsSlevaSmLabel = bicepsSlevaTextField.text
        sample?.bicepsSpravaSmLabel = bicepsSpravaTextField.text
        sample?.bedroSlevaSmLabel = bedroSlevaTextField.text
        sample?.bedroSpravaSmLabel = bedroSpravaTextField.text
        sample?.ikraSlevaSmLabel = ikraSlevaTextField.text
        sample?.ikraSpravaSmLabel = ikraSpravaTextField.text
        
        do {
            try context.save()
            
            dismiss(animated: true, completion: {
                self.delegate?.didEditSample(sample: self.sample!)
            })
            
        } catch let saveErr {
            print("Изменения не сохранены", saveErr)
        }
    }
    
    private func createSample() {
        
        guard let sampleData = dateTextField.text else { return }
        guard let sampleVes = vesTextField.text else { return }
        guard let sampleRost = rostTextField.text else { return }
        guard let sampleSheja = shejaTextField.text else { return }
        guard let sampleGrud = grudTextField.text else { return }
        guard let sampleTalija = talijaTextField.text else { return }
        guard let sampleBedra = bedraTextField.text else { return }
        guard let sampleBicepsSleva = bicepsSlevaTextField.text else { return }
        guard let sampleBicepsSprava = bicepsSpravaTextField.text else { return }
        guard let sampleBedroSleva = bedroSlevaTextField.text else { return }
        guard let sampleBedroSprava = bedroSpravaTextField.text else { return }
        guard let sampleIkraSleva = ikraSlevaTextField.text else { return }
        guard let sampleIkraSprava = ikraSpravaTextField.text else { return }
        
        if sampleData.isEmpty || sampleVes.isEmpty || sampleRost.isEmpty || sampleSheja.isEmpty || sampleGrud.isEmpty || sampleTalija.isEmpty || sampleBedra.isEmpty || sampleBicepsSleva.isEmpty || sampleBicepsSprava.isEmpty || sampleBedroSleva.isEmpty || sampleBedroSprava.isEmpty || sampleIkraSleva.isEmpty || sampleIkraSprava.isEmpty {
            showError(title: "Не все поля заполнены!", message: "Заполните все поля!")
            return
        }
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let sample = NSEntityDescription.insertNewObject(forEntityName: "Sample", into: context)
        
        sample.setValue(dateTextField.text, forKey: "dataLabel")
        sample.setValue(vesTextField.text, forKey: "vesSmLabel")
        sample.setValue(rostTextField.text, forKey: "rostSmLabel")
        sample.setValue(shejaTextField.text, forKey: "shejaSmLabel")
        sample.setValue(grudTextField.text, forKey: "grudSmLabel")
        sample.setValue(talijaTextField.text, forKey: "talijaSmLabel")
        sample.setValue(bedraTextField.text, forKey: "bedraSmLabel")
        sample.setValue(bicepsSlevaTextField.text, forKey: "bicepsSlevaSmLabel")
        sample.setValue(bicepsSpravaTextField.text, forKey: "bicepsSpravaSmLabel")
        sample.setValue(bedroSlevaTextField.text, forKey: "bedroSlevaSmLabel")
        sample.setValue(bedroSpravaTextField.text, forKey: "bedroSpravaSmLabel")
        sample.setValue(ikraSlevaTextField.text, forKey: "ikraSlevaSmLabel")
        sample.setValue(ikraSpravaTextField.text, forKey: "ikraSpravaSmLabel")
        do {
            try context.save()
            
            dismiss(animated: true, completion: {
                self.delegate?.didAddSample(sample: sample as! Sample)
            })
            
        } catch let saveErr {
            print("Замер не сохранен:", saveErr)
        }
    }
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupUI() {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        
        view.addSubview(dataLabel)
        dataLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dataLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        dataLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        dataLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(dateTextField)
        dateTextField.leftAnchor.constraint(equalTo: dataLabel.rightAnchor).isActive = true
        dateTextField.bottomAnchor.constraint(equalTo: dataLabel.bottomAnchor).isActive = true
        dateTextField.topAnchor.constraint(equalTo: dataLabel.topAnchor).isActive = true
        dateTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(vesSmLabel)
        vesSmLabel.topAnchor.constraint(equalTo: dataLabel.bottomAnchor).isActive = true
        vesSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        vesSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        vesSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(vesTextField)
        vesTextField.leftAnchor.constraint(equalTo: vesSmLabel.rightAnchor).isActive = true
        vesTextField.bottomAnchor.constraint(equalTo: vesSmLabel.bottomAnchor).isActive = true
        vesTextField.topAnchor.constraint(equalTo: vesSmLabel.topAnchor).isActive = true
        vesTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(kgLabel)
        kgLabel.leftAnchor.constraint(equalTo: dateTextField.rightAnchor).isActive = true
        kgLabel.bottomAnchor.constraint(equalTo: vesTextField.bottomAnchor).isActive = true
        kgLabel.topAnchor.constraint(equalTo: vesTextField.topAnchor).isActive = true
        
        view.addSubview(rostSmLabel)
        rostSmLabel.topAnchor.constraint(equalTo: vesSmLabel.bottomAnchor).isActive = true
        rostSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        rostSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        rostSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(rostTextField)
        rostTextField.leftAnchor.constraint(equalTo: rostSmLabel.rightAnchor).isActive = true
        rostTextField.bottomAnchor.constraint(equalTo: rostSmLabel.bottomAnchor).isActive = true
        rostTextField.topAnchor.constraint(equalTo: rostSmLabel.topAnchor).isActive = true
        rostTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smShejaLabel)
        smShejaLabel.leftAnchor.constraint(equalTo: vesTextField.rightAnchor).isActive = true
        smShejaLabel.bottomAnchor.constraint(equalTo: rostTextField.bottomAnchor).isActive = true
        smShejaLabel.topAnchor.constraint(equalTo: rostTextField.topAnchor).isActive = true
        
        view.addSubview(shejaSmLabel)
        shejaSmLabel.topAnchor.constraint(equalTo: rostSmLabel.bottomAnchor).isActive = true
        shejaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        shejaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        shejaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(shejaTextField)
        shejaTextField.leftAnchor.constraint(equalTo: shejaSmLabel.rightAnchor).isActive = true
        shejaTextField.bottomAnchor.constraint(equalTo: shejaSmLabel.bottomAnchor).isActive = true
        shejaTextField.topAnchor.constraint(equalTo: shejaSmLabel.topAnchor).isActive = true
        shejaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smLabel)
        smLabel.leftAnchor.constraint(equalTo: rostTextField.rightAnchor).isActive = true
        smLabel.bottomAnchor.constraint(equalTo: shejaTextField.bottomAnchor).isActive = true
        smLabel.topAnchor.constraint(equalTo: shejaTextField.topAnchor).isActive = true
        
        view.addSubview(grudSmLabel)
        grudSmLabel.topAnchor.constraint(equalTo: shejaSmLabel.bottomAnchor).isActive = true
        grudSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        grudSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        grudSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(grudTextField)
        grudTextField.leftAnchor.constraint(equalTo: grudSmLabel.rightAnchor).isActive = true
        grudTextField.bottomAnchor.constraint(equalTo: grudSmLabel.bottomAnchor).isActive = true
        grudTextField.topAnchor.constraint(equalTo: grudSmLabel.topAnchor).isActive = true
        grudTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smGrudLabel)
        smGrudLabel.leftAnchor.constraint(equalTo: shejaTextField.rightAnchor).isActive = true
        smGrudLabel.bottomAnchor.constraint(equalTo: grudTextField.bottomAnchor).isActive = true
        smGrudLabel.topAnchor.constraint(equalTo: grudTextField.topAnchor).isActive = true
        
        view.addSubview(talijaSmLabel)
        talijaSmLabel.topAnchor.constraint(equalTo: grudSmLabel.bottomAnchor).isActive = true
        talijaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        talijaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        talijaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(talijaTextField)
        talijaTextField.leftAnchor.constraint(equalTo: talijaSmLabel.rightAnchor).isActive = true
        talijaTextField.bottomAnchor.constraint(equalTo: talijaSmLabel.bottomAnchor).isActive = true
        talijaTextField.topAnchor.constraint(equalTo: talijaSmLabel.topAnchor).isActive = true
        talijaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smTalijaLabel)
        smTalijaLabel.leftAnchor.constraint(equalTo: grudTextField.rightAnchor).isActive = true
        smTalijaLabel.bottomAnchor.constraint(equalTo: talijaTextField.bottomAnchor).isActive = true
        smTalijaLabel.topAnchor.constraint(equalTo: talijaTextField.topAnchor).isActive = true
        
        view.addSubview(bedraSmLabel)
        bedraSmLabel.topAnchor.constraint(equalTo: talijaSmLabel.bottomAnchor).isActive = true
        bedraSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        bedraSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        bedraSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bedraTextField)
        bedraTextField.leftAnchor.constraint(equalTo: bedraSmLabel.rightAnchor).isActive = true
        bedraTextField.bottomAnchor.constraint(equalTo: bedraSmLabel.bottomAnchor).isActive = true
        bedraTextField.topAnchor.constraint(equalTo: bedraSmLabel.topAnchor).isActive = true
        bedraTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smBedraLabel)
        smBedraLabel.leftAnchor.constraint(equalTo: talijaTextField.rightAnchor).isActive = true
        smBedraLabel.bottomAnchor.constraint(equalTo: bedraTextField.bottomAnchor).isActive = true
        smBedraLabel.topAnchor.constraint(equalTo: bedraTextField.topAnchor).isActive = true
        
        view.addSubview(bicepsSlevaSmLabel)
        bicepsSlevaSmLabel.topAnchor.constraint(equalTo: bedraSmLabel.bottomAnchor).isActive = true
        bicepsSlevaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        bicepsSlevaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        bicepsSlevaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bicepsSlevaTextField)
        bicepsSlevaTextField.leftAnchor.constraint(equalTo: bicepsSlevaSmLabel.rightAnchor).isActive = true
        bicepsSlevaTextField.bottomAnchor.constraint(equalTo: bicepsSlevaSmLabel.bottomAnchor).isActive = true
        bicepsSlevaTextField.topAnchor.constraint(equalTo: bicepsSlevaSmLabel.topAnchor).isActive = true
        bicepsSlevaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smBicepsSlevaLabel)
        smBicepsSlevaLabel.leftAnchor.constraint(equalTo: bedraTextField.rightAnchor).isActive = true
        smBicepsSlevaLabel.bottomAnchor.constraint(equalTo: bicepsSlevaTextField.bottomAnchor).isActive = true
        smBicepsSlevaLabel.topAnchor.constraint(equalTo: bicepsSlevaTextField.topAnchor).isActive = true
        
        view.addSubview(bicepsSpravaSmLabel)
        bicepsSpravaSmLabel.topAnchor.constraint(equalTo: bicepsSlevaSmLabel.bottomAnchor).isActive = true
        bicepsSpravaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        bicepsSpravaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        bicepsSpravaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bicepsSpravaTextField)
        bicepsSpravaTextField.leftAnchor.constraint(equalTo: bicepsSpravaSmLabel.rightAnchor).isActive = true
        bicepsSpravaTextField.bottomAnchor.constraint(equalTo: bicepsSpravaSmLabel.bottomAnchor).isActive = true
        bicepsSpravaTextField.topAnchor.constraint(equalTo: bicepsSpravaSmLabel.topAnchor).isActive = true
        bicepsSpravaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smBicepsSpravaLabel)
        smBicepsSpravaLabel.leftAnchor.constraint(equalTo: bicepsSlevaTextField.rightAnchor).isActive = true
        smBicepsSpravaLabel.bottomAnchor.constraint(equalTo: bicepsSpravaTextField.bottomAnchor).isActive = true
        smBicepsSpravaLabel.topAnchor.constraint(equalTo: bicepsSpravaTextField.topAnchor).isActive = true
        
        
        view.addSubview(bedroSlevaSmLabel)
        bedroSlevaSmLabel.topAnchor.constraint(equalTo: bicepsSpravaSmLabel.bottomAnchor).isActive = true
        bedroSlevaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        bedroSlevaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        bedroSlevaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bedroSlevaTextField)
        bedroSlevaTextField.leftAnchor.constraint(equalTo: bedroSlevaSmLabel.rightAnchor).isActive = true
        bedroSlevaTextField.bottomAnchor.constraint(equalTo: bedroSlevaSmLabel.bottomAnchor).isActive = true
        bedroSlevaTextField.topAnchor.constraint(equalTo: bedroSlevaSmLabel.topAnchor).isActive = true
        bedroSlevaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smBedroSlevaLabel)
        smBedroSlevaLabel.leftAnchor.constraint(equalTo: bicepsSpravaTextField.rightAnchor).isActive = true
        smBedroSlevaLabel.bottomAnchor.constraint(equalTo: bedroSlevaTextField.bottomAnchor).isActive = true
        smBedroSlevaLabel.topAnchor.constraint(equalTo: bedroSlevaTextField.topAnchor).isActive = true
        
        
        view.addSubview(bedroSpravaSmLabel)
        bedroSpravaSmLabel.topAnchor.constraint(equalTo: bedroSlevaSmLabel.bottomAnchor).isActive = true
        bedroSpravaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        bedroSpravaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        bedroSpravaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bedroSpravaTextField)
        bedroSpravaTextField.leftAnchor.constraint(equalTo: bedroSpravaSmLabel.rightAnchor).isActive = true
        bedroSpravaTextField.bottomAnchor.constraint(equalTo: bedroSpravaSmLabel.bottomAnchor).isActive = true
        bedroSpravaTextField.topAnchor.constraint(equalTo: bedroSpravaSmLabel.topAnchor).isActive = true
        bedroSpravaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smBedroSpravaLabel)
        smBedroSpravaLabel.leftAnchor.constraint(equalTo: bedroSlevaTextField.rightAnchor).isActive = true
        smBedroSpravaLabel.bottomAnchor.constraint(equalTo: bedroSpravaTextField.bottomAnchor).isActive = true
        smBedroSpravaLabel.topAnchor.constraint(equalTo: bedroSpravaTextField.topAnchor).isActive = true
        
        view.addSubview(ikraSlevaSmLabel)
        ikraSlevaSmLabel.topAnchor.constraint(equalTo: bedroSpravaSmLabel.bottomAnchor).isActive = true
        ikraSlevaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        ikraSlevaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        ikraSlevaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(ikraSlevaTextField)
        ikraSlevaTextField.leftAnchor.constraint(equalTo: ikraSlevaSmLabel.rightAnchor).isActive = true
        ikraSlevaTextField.bottomAnchor.constraint(equalTo: ikraSlevaSmLabel.bottomAnchor).isActive = true
        ikraSlevaTextField.topAnchor.constraint(equalTo: ikraSlevaSmLabel.topAnchor).isActive = true
        ikraSlevaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smIkraSlevaLabel)
        smIkraSlevaLabel.leftAnchor.constraint(equalTo: bedroSpravaTextField.rightAnchor).isActive = true
        smIkraSlevaLabel.bottomAnchor.constraint(equalTo: ikraSlevaTextField.bottomAnchor).isActive = true
        smIkraSlevaLabel.topAnchor.constraint(equalTo: ikraSlevaTextField.topAnchor).isActive = true
        
        view.addSubview(ikraSpravaSmLabel)
        ikraSpravaSmLabel.topAnchor.constraint(equalTo: ikraSlevaSmLabel.bottomAnchor).isActive = true
        ikraSpravaSmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        ikraSpravaSmLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        ikraSpravaSmLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(ikraSpravaTextField)
        ikraSpravaTextField.leftAnchor.constraint(equalTo: ikraSpravaSmLabel.rightAnchor).isActive = true
        ikraSpravaTextField.bottomAnchor.constraint(equalTo: ikraSpravaSmLabel.bottomAnchor).isActive = true
        ikraSpravaTextField.topAnchor.constraint(equalTo: ikraSpravaSmLabel.topAnchor).isActive = true
        ikraSpravaTextField.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        view.addSubview(smIkraSpravaLabel)
        smIkraSpravaLabel.leftAnchor.constraint(equalTo: ikraSlevaTextField.rightAnchor).isActive = true
        smIkraSpravaLabel.bottomAnchor.constraint(equalTo: ikraSpravaTextField.bottomAnchor).isActive = true
        smIkraSpravaLabel.topAnchor.constraint(equalTo: ikraSpravaTextField.topAnchor).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
