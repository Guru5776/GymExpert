//
//  EmployeesController.swift
//  GymExpert
//
//  Created by Admin on 1/17/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData

class IndentedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let container = CGRect(x: 0, y: 0, width: 150, height: 50)
        let margin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customeframe = container.inset(by: margin)
        super.drawText(in: customeframe)
    }
    
}

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    
    func didAddEmployee(employee: Employee) {
//        employees.append(employee)
//        fetchEmployees()
//        tableView.reloadData()
        guard let section = employeeTypes.index(of: employee.type!) else { return }
        
        let row = allEmployee[section].count
        
        let insertionIndexPath = IndexPath(row: row, section: section)
        
        allEmployee[section].append(employee)
        
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
    }
    
    var workout: Workout?
    
    var employees = [Employee]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = workout?.name
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        if section == 0 {
            label.text = "Понедельник"
        } else if section == 1{
            label.text = "Вторник"
        } else if section == 2{
            label.text = "Среда"
        } else if section == 3{
            label.text = "Четверг"
        } else if section == 4{
            label.text = "Пятница"
        } else if section == 5{
            label.text = "Суббота"
        } else if section == 6{
            label.text = "Воскресенье"
        }
        
        label.backgroundColor = UIColor.lightBlue
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    var mondayEmployee = [Employee]()
    var tuesdayEmployee = [Employee]()
    var wednesdayEployee = [Employee]()
    var thursdayEployee = [Employee]()
    var fridayEployee = [Employee]()
    var saturdayEployee = [Employee]()
    var sundayEployee = [Employee]()
    
    var allEmployee = [[Employee]]()
    
    var employeeTypes = [
        EmployeeType.mondayEmployee.rawValue,
        EmployeeType.tuesdayEmployee.rawValue,
        EmployeeType.wednesdayEployee.rawValue,
        EmployeeType.thursdayEployee.rawValue,
        EmployeeType.fridayEployee.rawValue,
        EmployeeType.saturdayEployee.rawValue,
        EmployeeType.sundayEployee.rawValue
    ]
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") { (_, indexPath) in
//            let employee = self.employees[indexPath.row]
//
//            self.employees.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//
//            let context = CoreDataManager.shared.persistentContainer.viewContext
//            context.delete(employee)
//
//            do {
//                try context.save()
//            } catch let saveErr {
//                print("Failed to delete workout:", saveErr)
//            }
//        }
//        deleteAction.backgroundColor = UIColor.lightRed
//
//        return [deleteAction]
//    }
    
    private func fetchEmployees() {
        guard let workoutEployees = workout?.employees?.allObjects as? [Employee] else { return }
        
        allEmployee = []
        
        employeeTypes.forEach { (employeeType) in
            allEmployee.append(
                workoutEployees.filter { $0.type == employeeType }
            )
        }
        
//        let mondays = workoutEployees.filter { (employee) -> Bool in
//            return employee.type == EmployeeType.mondayEmployee.rawValue
//        }
//
//        let tuesday = workoutEployees.filter { $0.type == EmployeeType.tuesdayEmployee.rawValue }
//
//        allEmployee = [
//        mondays,
//        tuesday,
//        workoutEployees.filter { $0.type == EmployeeType.wednesdayEployee.rawValue },
//        workoutEployees.filter { $0.type == EmployeeType.thursdayEployee.rawValue },
//        workoutEployees.filter { $0.type == EmployeeType.fridayEployee.rawValue },
//        workoutEployees.filter { $0.type == EmployeeType.saturdayEployee.rawValue },
//        workoutEployees.filter { $0.type == EmployeeType.sundayEployee.rawValue }
//        ]
//
   }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployee.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployee[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        
        let employee = allEmployee[indexPath.section][indexPath.row]
        
        if let nameLabel = employee.name,  let sideLabel = employee.sideLabel, let repeatLabel = employee.repeatLabel {
            
            let nameSample = "\(nameLabel)\n\(sideLabel) x \(repeatLabel) повт."
            
            cell.textLabel?.text = nameSample
            cell.textLabel?.numberOfLines = 0
            cell.backgroundColor = .tealColor
            
        } else {
            cell.textLabel?.text = employee.name
        }
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        return cell
    }
    
    let cellId = "cellllllllllllId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        
        tableView.backgroundColor = UIColor.darkBlue
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    @objc private func handleAdd() {
        print("Trying to add an employee..")
        
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.workout = workout
        let navController = UINavigationController(rootViewController: createEmployeeController)
        present(navController, animated: true, completion: nil)
    }
    
}







