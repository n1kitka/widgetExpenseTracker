//
//  AddItemTableViewCell.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 07.05.2023.
//

import UIKit

class AddItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var addItemImage: UIImageView!
    @IBOutlet weak var addItemView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addItemView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
