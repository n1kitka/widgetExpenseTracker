//
//  AddSumViewController.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 08.05.2023.
//

import UIKit


class AddSumViewController: UIViewController {
    
    var history = HistoryModel()
    let date = Date()
    let dateFormatter = DateFormatter()

    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var amountTextField: UITextField!
    var segmentNumber:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.becomeFirstResponder()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let amountText = amountTextField.text, let amount = Double(amountText) {
                // Valid numeric value, post the notification
                history.getNewHistory(History(title: itemLabel.text!, image: itemImage.image!, cost: amountText, date: dateFormatter.string(from: date)))
            NotificationCenter.default.post(name: NSNotification.Name("getDataID"), object: nil, userInfo: ["label": amount, "segment": segmentNumber!])
                navigationController?.popViewController(animated: true)
            } else {
                // Show alert for invalid input
                let alert = UIAlertController(title: "Помилка", message: "Будь ласка введіть дійсну суму", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
}

