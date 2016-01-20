//
//  SummaryHeaderTableViewCell.swift
//  Expense
//
//  Created by Monica Ong on 1/14/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//
import UIKit

class SummaryHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var totalCostView: UIView!
    @IBOutlet weak var totalCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
