//
//  WorkoutDetailViewController.swift
//  GymExpert
//
//  Created by Admin on 11/28/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myImageView: UIImageView!
    var workout: trainingProgram?
    
    
    
    
    
    @IBAction func backButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView.image = UIImage(named: workout!.imageName)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.DescriptionLabel.text = workout!.descript
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}
