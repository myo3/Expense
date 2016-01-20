//
//  SummaryDetailTableViewCell.swift
//  Expense
//
//  Created by Monica Ong on 1/14/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class SummaryDetailTableViewCell: UITableViewCell {


    @IBOutlet weak var color: UIView!
    @IBOutlet weak var category: UIImageView!
    @IBOutlet weak var function: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var note: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
