//
//  CoreDataManager.swift
//  GymExpert
//
//  Created by Admin on 1/12/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GymExpert")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loadning of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchCompanies() -> [Workout] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        do {
            let workouts = try context.fetch(fetchRequest)
            return workouts
        } catch let fetchErr {
            print("Failed to fetch workouts:", fetchErr)
            return []
        }
    }
    
    func createEmployee(employeeName: String, employeeType: String, workout: Workout, employeeSide: String, employeeRepeat: String) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        
        //create an employee
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        employee.workout = workout
        employee.type = employeeType
        
//        let workout = Workout(context: context)
//        workout.employees
        
        
        
        employee.setValue(employeeName, forKey: "name")
        employee.setValue(employeeSide, forKey: "sideLabel")
        employee.setValue(employeeRepeat, forKey: "repeatLabel")
        
        do {
            try context.save()
            // save succeeds
            return (employee, nil)
        } catch let err {
            print("Failed to create employee:", err)
            return (nil, err)
        }
        
    }
}
