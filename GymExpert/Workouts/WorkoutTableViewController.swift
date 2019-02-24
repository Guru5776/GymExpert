//
//  WorkoutTableViewController.swift
//  GymExpert
//
//  Created by Admin on 1/8/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData

class WorkoutTableViewController: UITableViewController, CreateWorkoutControllerDelegate {
    
    let sectionImage: [UIImage] = [#imageLiteral(resourceName: "Программы.png")]
    
    var workouts = [Workout]()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let workout = self.workouts[indexPath.row]
        let employeesController = EmployeesController()
        employeesController.workout = workout
        navigationController?.pushViewController(employeesController, animated: true)
    }
    
    func didEditWorkot(workout: Workout) {
        let row = workouts.index(of: workout)
        
        let relodIndexPath = IndexPath(row: row!, section: 0)
        
        tableView.reloadRows(at: [relodIndexPath], with: .middle)
    }
    
    func didAddWorkout(workout: Workout) {
        workouts.append(workout)
        let newIndexPath = IndexPath(row: workouts.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") { (_, indexPath) in
            let workout = self.workouts[indexPath.row]
            
            self.workouts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(workout)
            
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete workout:", saveErr)
            }
        }
        deleteAction.backgroundColor = UIColor.lightRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Изменить", handler: editHandlerFunction)
        
        editAction.backgroundColor = UIColor.darkBlue
        
        return [deleteAction, editAction]
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("Editing workout in separate function")
        
        let editWorkoutController = CreateWorkoutController()
        editWorkoutController.delegate = self
        editWorkoutController.workout = workouts[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editWorkoutController)
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchWorkouts() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        
        do {
            let workouts = try context.fetch(fetchRequest)
            
            workouts.forEach({ (workout) in
                print(workout.name ?? "")
            })
            
            self.workouts = workouts
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch workouts:", fetchErr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWorkouts()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Программы"
        tableView.backgroundColor = UIColor.darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(WorkoutCell.self, forCellReuseIdentifier: "cellId")
        
        setupPlusButtonInNavBar(selectore: #selector(handleAddWorkout))
    }
    
    @objc func handleAddWorkout() {
        
        let createWorkoutController = CreateWorkoutController()
        
        let navController = CustomNavigationController(rootViewController: createWorkoutController)
        
        createWorkoutController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        
        let image = UIImageView(image: sectionImage[section])
        image.frame = CGRect(x: 16, y: 5, width: 35, height: 35)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = "Мои программы"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkBlue
        label.frame = CGRect(x: 56, y: 5, width: 200, height: 35)
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! WorkoutCell
        
        let workout = workouts[indexPath.row]
        cell.workout = workout
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
}
