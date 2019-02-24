//
//  SampleDetailViewController.swift
//  GymExpert
//
//  Created by Admin on 12/21/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit

class SampleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var samples: Sample?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SampleDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Рост"
            cell.countLabel.text = samples?.rostSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 1:
            cell.nameLabel.text = "Вес"
            cell.countLabel.text = samples?.vesSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 2:
            cell.nameLabel.text = "Шея"
            cell.countLabel.text = samples?.shejaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 3:
            cell.nameLabel.text = "Грудь"
            cell.countLabel.text = samples?.grudSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 4:
            cell.nameLabel.text = "Талия"
            cell.countLabel.text = samples?.talijaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 5:
            cell.nameLabel.text = "Бедра"
            cell.countLabel.text = samples?.bedraSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 6:
            cell.nameLabel.text = "Бецепс (слева)"
            cell.countLabel.text = samples?.bicepsSlevaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 7:
            cell.nameLabel.text = "Бицепс (справа)"
            cell.countLabel.text = samples?.bicepsSpravaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 8:
            cell.nameLabel.text = "Бедро (слева)"
            cell.countLabel.text = samples?.bedroSlevaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 9:
            cell.nameLabel.text = "Бедро (справа)"
            cell.countLabel.text = samples?.bedroSpravaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 10:
            cell.nameLabel.text = "Икра (слева)"
            cell.countLabel.text = samples?.ikraSlevaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
        case 11:
            cell.nameLabel.text = "Икра (справа)"
            cell.countLabel.text = samples?.ikraSpravaSmLabel
            cell.backgroundColor = .tealColor
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.countLabel.font = UIFont.boldSystemFont(ofSize: 18)
            cell.nameLabel.textColor = .darkBlue
            cell.countLabel.textColor = .darkBlue
            
        default:
            break
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

