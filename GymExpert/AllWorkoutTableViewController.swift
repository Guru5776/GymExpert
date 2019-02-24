//
//  AllWorkoutTableViewController.swift
//  GymExpert
//
//  Created by Admin on 11/28/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class AllWorkoutTableViewController: UITableViewController {
    
    var muscles:[Muscle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let exercises1 = [trainingProgram(workoutName:"Боковые наклоны с гантелью", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Пресс", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Боковые наклоны с гантелью", imageName:"body.jpg", descript:"Описание")]
        let exercises2 = [trainingProgram(workoutName:"Боковые наклоны с гантелью", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание")]
        let exercises3 = [trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body", descript:"Описание")]
        let exercises4 = [trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body", descript:"Описание")]
        let exercises5 = [trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body", descript:"Описание")]
        let exercises6 = [trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body", descript:"Описание")]
        let exercises7 = [trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body", descript:"Описание")]
        let exercises8 = [trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание"), trainingProgram(workoutName:"Exercise", imageName:"body.jpg", descript:"Описание")]
        
        
        
        muscles = [
            Muscle(muscleName: "Все упражнения", workouts: exercises1, imageName: "body.jpg"),
            Muscle(muscleName: "Пресс", workouts: exercises2, imageName: "body.jpg"),
            Muscle(muscleName: "Руки", workouts: exercises3, imageName: "body.jpg"),
            Muscle(muscleName: "Спина", workouts: exercises4, imageName: "body.jpg"),
            Muscle(muscleName: "Грудь", workouts: exercises5, imageName: "body.jpg"),
            Muscle(muscleName: "Плечи", workouts: exercises6, imageName: "body.jpg"),
            Muscle(muscleName: "Ноги", workouts: exercises7, imageName: "body.jpg"),
            Muscle(muscleName: "Кардио", workouts: exercises8, imageName: "body.jpg")
        ]
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return muscles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageCell
        
        let muscle = muscles[indexPath.row]
        
        cell.imageView1.image = UIImage(named:muscle.imageName)
        
        cell.label1.text = muscle.muscleName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let muscle = muscles[indexPath.row]
        
        performSegue(withIdentifier: "OpenTVC2Identifier", sender: muscle)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenTVC2Identifier" {
            let muscle = sender as! Muscle
            let vc = segue.destination as! WorkoutTableViewController
            vc.muscle = muscle
        }
        func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
            if (segue.identifier == "detailSegue") {
                let workout = sender as! trainingProgram
                let dvc = segue.destination as! WorkoutDetailViewController
                // pass data to next view
            }
            
        }
    }
}

