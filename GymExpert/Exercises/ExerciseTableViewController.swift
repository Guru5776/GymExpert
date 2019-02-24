//
//  WorkoutTableViewController.swift
//  GymExpert
//
//  Created by Admin on 1/8/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData
import SwiftyGif

class ExerciseTableViewController: UITableViewController, NewExerciseControllerDelegate {
    
    var context: NSManagedObjectContext!
    
    let sectionImage: [UIImage] = [#imageLiteral(resourceName: "Упражнения.png")]
    
    var exercises = [Exercise]()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exercise = self.exercises[indexPath.row]
        let exerciseDetailController = ExerciseDetailController()
        exerciseDetailController.exercise = exercise
        navigationController?.pushViewController(exerciseDetailController, animated: true)
        
    }
    
    func didEditExercise(exercise: Exercise) {
        let row = exercises.index(of: exercise)
        
        let relodIndexPath = IndexPath(row: row!, section: 0)
        
        tableView.reloadRows(at: [relodIndexPath], with: .middle)
    }
    
    func didAddExercise(exercise: Exercise) {
        exercises.append(exercise)
        let newIndexPath = IndexPath(row: exercises.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") { (_, indexPath) in
            let exercise = self.exercises[indexPath.row]
            
            self.exercises.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(exercise)
            
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
        print("Editing exercise in separate function")
        
        let editExerciseController = NewExerciseTableViewController()
        editExerciseController.delegate = self
        editExerciseController.exercise = exercises[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editExerciseController)
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchExercises() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")
        
        do {
            let exercises = try context.fetch(fetchRequest)
            
            exercises.forEach({ (exercise) in
                print(exercise.name ?? "")
            })
            
            self.exercises = exercises
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch exercises:", fetchErr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchExercises()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Упражнения"
        tableView.backgroundColor = UIColor.darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        
        tableView.register(ExerciseCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddExercise))
    }
    
    @objc func handleAddExercise() {
        
        let newExerciseTableViewController = NewExerciseTableViewController()
        
        let navController = CustomNavigationController(rootViewController: newExerciseTableViewController)
        
        newExerciseTableViewController.delegate = self
        
        present(navController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        
        let image = UIImageView(image: sectionImage[section])
        image.frame = CGRect(x: 16, y: 5, width: 35, height: 35)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = "Все упражнения"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ExerciseCell
        
        let exercise = exercises[indexPath.row]
        cell.exercise = exercise
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
}
