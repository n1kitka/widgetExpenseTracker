//
//  HomeTableViewCell.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 05.05.2023.
//

import UIKit
import CoreData


class HomeTableViewCell: UITableViewCell {
    
    let incomesModel = Incomes()
    let expensesModel = Expenses()
    
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionDate: UILabel!
    @IBOutlet weak var actionAmount: UILabel!
    @IBOutlet weak var actionView: UIView!
    
    func configure(withHistory history: HistoryEntity) {
        DispatchQueue.main.async { [self] in
            actionLabel.text = history.title
            actionImage.image = UIImage(data: history.image!)
            actionDate.text = history.date
            if incomesModel.incomes.contains(where: { $0.title == history.title }) {
                actionAmount.text = "₴\(Double(history.cost!)!)"
            } else if expensesModel.expenses.contains(where: { $0.title == history.title }) {
                actionAmount.text = "-₴\(Double(history.cost!)!)"
            }
        }

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //actionView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
