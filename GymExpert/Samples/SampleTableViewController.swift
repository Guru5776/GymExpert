//
//  WorkoutTableViewController.swift
//  GymExpert
//
//  Created by Admin on 1/8/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData

class SampleTableViewController: UITableViewController, CreateSampleControllerDelegate {
    
    let sectionImage: [UIImage] = [#imageLiteral(resourceName: "Замеры.png")]
    var samples = [Sample]()
    
    func didEditSample(sample: Sample) {
        let row = samples.index(of: sample)
        let relodIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [relodIndexPath], with: .middle)
    }
    
    func didAddSample(sample: Sample) {
        samples.append(sample)
        let newIndexPath = IndexPath(row: samples.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") { (_, indexPath) in
            let sample = self.samples[indexPath.row]
            self.samples.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(sample)
            
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete sample:", saveErr)
            }
        }
        deleteAction.backgroundColor = UIColor.lightRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Изменить", handler: editHandlerFunction)
        editAction.backgroundColor = UIColor.darkBlue
        return [deleteAction, editAction]
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("Editing sample in separate function")
        
        let editSampleController = CreateSampleController()
        editSampleController.delegate = self
        editSampleController.sample = samples[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editSampleController)
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchSamples() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Sample>(entityName: "Sample")
        do {
            let samples = try context.fetch(fetchRequest)
            samples.forEach({ (sample) in
                print(sample.dataLabel ?? "")
            })
            self.samples = samples
            self.tableView.reloadData()
        } catch let fetchErr {
            print("Failed to fetch samples:", fetchErr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSamples()
        
        view.backgroundColor = .white
        navigationItem.title = "Мои замеры"
        tableView.backgroundColor = UIColor.darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddSample))
    }
    
    @objc func handleAddSample() {
        let createSampleController = CreateSampleController()
        let navController = CustomNavigationController(rootViewController: createSampleController)
        createSampleController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        
        let image = UIImageView(image: sectionImage[section])
        image.frame = CGRect(x: 16, y: 5, width: 35, height: 35)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = "Мои замеры"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkBlue
        label.frame = CGRect(x: 56, y: 5, width: 200, height: 35)
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.backgroundColor = .tealColor
        
        let sample = samples[indexPath.row]
        
        if let dataLabel = sample.dataLabel, let rostLabel = sample.rostSmLabel, let vesLabel = sample.vesSmLabel, let shejaLabel = sample.shejaSmLabel, let grudLabel = sample.grudSmLabel, let talijaLabel = sample.talijaSmLabel, let bedraLabel = sample.bedraSmLabel, let bicepsSleva = sample.bicepsSlevaSmLabel, let bicepsSprava = sample.bicepsSpravaSmLabel, let bedroSleva = sample.bedroSlevaSmLabel, let bedroSprava = sample.bedroSpravaSmLabel, let ikraSleva = sample.ikraSlevaSmLabel, let ikraSprava = sample.ikraSpravaSmLabel {
            
            let nameSample = "\(dataLabel)\nРост: \(rostLabel) см., Вес: \(vesLabel) кг., Шея: \(shejaLabel) см., Грудь: \(grudLabel) см.,\nТалия: \(talijaLabel) см., Бедра: \(bedraLabel) см., Бицепс(слева): \(bicepsSleva) см.,\nБицепс(справа): \(bicepsSprava) см., Бедро(слева): \(bedroSleva) см.,\nБедро(справа): \(bedroSprava) см., Икра(слева): \(ikraSleva) см.,\nИкра(справа): \(ikraSprava) см."
            
            cell.textLabel?.text = nameSample
            cell.textLabel?.numberOfLines = 0
            
        } else {
            cell.textLabel?.text = sample.dataLabel
        }
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return samples.count
        
    }
}
