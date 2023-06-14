//
//  HomeViewController.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 05.05.2023.
//

import UIKit
import CoreData
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCurrent: UILabel!
    @IBOutlet weak var barChartView: BarChartView!

    
    let context = PersistenceController.shared.persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    let addSumViewController = AddSumViewController()
    let dateFormatter = DateFormatter()
    var history = HistoryModel()
    let incomesModel = Incomes()
    let barChartManager = BarChartManager()
    
    var newIncomes = 0.0
    var newExpenses = 0.0
    var incomes = 0.0
    var expenses = 0.0
    var current = 0.0
    var newCurrent = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reset()
        
        setupLabel()
        history.loadCategories()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCellID")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.hidesBarsOnSwipe = true
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData(notification:)), name: NSNotification.Name("getDataID"), object: nil)
        
        barChartManager.configureBarChart(barChartView)
        barChartManager.updateBarChartData(barChartView)
    }
    
    @objc func getData(notification:Notification) {

        if let userInfo = notification.userInfo {
            let amount = userInfo["label"] as! Double
            let segment = userInfo["segment"] as! Int
            
            if segment == 0 {
                newCurrent = history.getTotalCurrent(segment, amount) + current
                self.defaults.set(newCurrent, forKey: "Current")
                
            } else {
                newCurrent = history.getTotalCurrent(segment, amount) + current
                self.defaults.set(newCurrent, forKey: "Current")
            }
                          
            if newCurrent >= 0 {
                totalCurrent.text = "₴\(String(newCurrent))"
            } else {
                totalCurrent.text = "-₴\(String(-newCurrent))"
            }
            
            barChartManager.updateBarChartData(barChartView)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupLabel() {
        current = defaults.double(forKey: "Current")
        if current >=  0 {
            totalCurrent.text = "₴\(String(current))"
        } else {
            totalCurrent.text = "-₴\(String(-current))"
        }
    }
    
    func reset() {
        let fetchRequest: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error deleting transactions: \(error.localizedDescription)")
        }
        current = 0
        defaults.set(current, forKey: "Current")
        totalCurrent.text = "₴0"
        tableView.reloadData()
    }
    
    @IBAction func goToTransactionView(_ sender: UIButton) {
        performSegue(withIdentifier: "transactionSegue", sender: nil)
    }
    
}

// MARK: - Configure Table -
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellID", for: indexPath) as! HomeTableViewCell
        let historyItem = history.getHistory(indexPath.row)
        cell.configure(withHistory: historyItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.getRowInSection()
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            history.deleteHistory(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            
        }
    }
     
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
         let header = view as? UITableViewHeaderFooterView
         header?.textLabel?.textColor = UIColor.white
         header?.backgroundConfiguration = .clear()
     }
}






























    

