//
//  AddViewController.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 07.05.2023.
//

import UIKit

class AddViewController: UIViewController {
    
    
    var incomesModel = Incomes()
    var expensesModel = Expenses()
    private var segmentNumber = 0
    private var setupIndex = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "AddItemTableViewCell", bundle: nil), forCellReuseIdentifier: "AddItemCellID")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        segmentNumber = sender.selectedSegmentIndex
        tableView.reloadData()
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return incomesModel.incomes.count
        } else {
            return expensesModel.expenses.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddItemCellID", for: indexPath) as! AddItemTableViewCell
        
        if segmentNumber == 0 { // Display incomes data
            let incomeItem = incomesModel.incomes[indexPath.row]
            cell.salaryLabel.text = incomeItem.title
            cell.addItemImage.image = UIImage(named: incomeItem.image)
        } else { // Display expenses data
            let expenseItem = expensesModel.expenses[indexPath.row]
            cell.salaryLabel.text = expenseItem.title
            cell.addItemImage.image = UIImage(named: expenseItem.image)
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedItem: Item
            if segmentedControl.selectedSegmentIndex == 0 {
                selectedItem = incomesModel.incomes[indexPath.row]
            } else {
                selectedItem = expensesModel.expenses[indexPath.row]
            }
        performSegue(withIdentifier: "goToAddSum", sender: selectedItem)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddSum" {
            let destinationVC = segue.destination as! AddSumViewController
            
            if let selectedItem = sender as? Item {
                DispatchQueue.main.async{
                    destinationVC.itemLabel.text = selectedItem.title
                    destinationVC.itemImage.image = UIImage(named: selectedItem.image)
                    destinationVC.segmentNumber = self.segmentedControl.selectedSegmentIndex
                    
                }
            }
        }
    }
}


