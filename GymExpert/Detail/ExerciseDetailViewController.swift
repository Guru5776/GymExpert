//
//  ExerciseDetailViewController.swift
//  GymExpert
//
//  Created by Admin on 10/17/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var exercise: Exercise?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 28
        tableView.rowHeight = UITableView.automaticDimension
        
        imageView.image = UIImage(data: exercise!.image! as Data)
        imageView.backgroundColor = .lightBlue
        
        
        tableView.backgroundColor = .darkBlue
        //        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        
        title = exercise!.name
        
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExerciseDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.DescriptionLabel.text = exercise?.descriptLabel
            cell.backgroundColor = .tealColor
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
}
