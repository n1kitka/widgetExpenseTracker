//
//  SettingsViewController.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 14.05.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    let settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.layer.cornerRadius = 10
    }
    
}

extension SettingsViewController: UITableViewDelegate , UITableViewDataSource {
        
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.settings[section].count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell",for: indexPath)
        cell.layer.cornerRadius = 7
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = settings.settings[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let selectedCellText = cell?.textLabel?.text ?? ""
        
        if selectedCellText == "Довідка" {
            performSegue(withIdentifier: "goToDovidka", sender: self)
        }
        if selectedCellText == "Задонатити на ЗСУ" {
            performSegue(withIdentifier: "goToDonate", sender: self)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // adjust this value to increase or decrease the height of the cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5 // adjust this value to increase or decrease the height of the space between sections
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5)) // adjust the height to match the heightForHeaderInSection method
    }

    
}
