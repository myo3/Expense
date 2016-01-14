//
//  SummaryHeaderTableViewCell.swift
//  Expense
//
//  Created by Monica Ong on 1/14/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//
import UIKit

protocol SummaryHeaderTableViewCellDelegate {
    func didSelectUserHeaderTableViewCell(Selected: Bool, header: SummaryHeaderTableViewCell)
}

class SummaryHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var totalCostView: UIView!
    @IBOutlet weak var totalCost: UILabel!
    
    var delegate : SummaryHeaderTableViewCellDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func headerSelected(sender: UIButton) {
        delegate?.didSelectUserHeaderTableViewCell(true, header: self)
    }
}
