//
//  SummaryTableViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/7/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

enum Day: String{
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class SummaryTableViewController:  UITableViewController, SummaryHeaderTableViewCellDelegate {
    
    var dayOfWeek: [Day] = [Day]()
    var totalSpentPerDay: [Double] = [Double]()
    var colorOfDay: [Day: UIColor] = [ .Mon: UIColor(netHex:0x7BD33E), .Tue: UIColor(netHex: 0x3DCDCC), .Wed: UIColor(netHex: 0xFD8E62), .Thu: UIColor(netHex: 0xA364D8), .Fri: UIColor(netHex: 0xE2679A), .Sat: UIColor(netHex: 0xF2DA5E), .Sun: UIColor(netHex: 0xEE6E5D)]
    
    var expandedCellPaths: [NSIndexPath] = [NSIndexPath]()
    var normalCellHeight: CGFloat = 70
    var lastCellIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayOfWeek = [ .Mon, .Tue, .Wed, .Thu, .Fri, .Sat, .Sun]
        totalSpentPerDay = [0, 7.27, 0, 40, 39, 0, 0]
        
        //Set up format
        normalCellHeight = (view.bounds.height - self.navigationController!.navigationBar.bounds.height - 15)/(CGFloat(self.dayOfWeek.count) + 1)
        lastCellIndex = self.dayOfWeek.count
        
        //Register nibs
//        let summaryCellNib = UINib(nibName: "summaryCell", bundle: nil)
//        tableView.registerNib(summaryCellNib, forCellReuseIdentifier: "summaryCell")
//        let allExpenseNib = UINib(nibName: "allExpenseCell", bundle: nil)
//        tableView.registerNib(allExpenseNib, forCellReuseIdentifier: "allExpenseCell")
        
        //Make seperator white & skinny
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
        self.tableView.separatorColor = UIColor.whiteColor()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("headerCell") as! 
        SummaryHeaderTableViewCell
        header.delegate = self
        header.index = section
        let day = dayOfWeek[section]
        header.dayOfWeek.text = day.rawValue.uppercaseString
        header.dayOfWeek.backgroundColor = colorOfDay[day]
        header.totalCost.text = "$\(totalSpentPerDay[section])"
        header.totalCostView.backgroundColor = colorOfDay[day]
//        header.selectionStyle = .None
        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func didSelectUserHeaderTableViewCell(Selected: Bool, header: SummaryHeaderTableViewCell) {
        print("Header \(header.index) Selected!")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let detail = tableView.dequeueReusableCellWithIdentifier("detailCell") as! SummaryDetailTableViewCell
        let day = dayOfWeek[indexPath.row]
        detail.color.backgroundColor = colorOfDay[day]
        
        detail.category.image = UIImage(named: "General")
        detail.category.contentMode = .ScaleAspectFit
        detail.function.text = "Social"
        detail.cost.text = "$5"
        detail.note.text = "noting down stuff okay done blah blah blah..."
        detail.selectionStyle = .None
        return detail

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.row != lastCellIndex{
//            if expandedCellPaths.contains(indexPath){
//                let index = expandedCellPaths.indexOf(indexPath)
//                expandedCellPaths.removeAtIndex(index!)
//            }else{
//                expandedCellPaths.append(indexPath)
//            }
//            
//            //old trick to animate cell expand/collapse
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }


        print("Row \(indexPath.row) selected")
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row != lastCellIndex{
//            let expandedCellHeight = normalCellHeight*2
//            if expandedCellPaths.contains(indexPath){
//                return expandedCellHeight
//            }else{
//                return normalCellHeight
//            }
//        } else{
//            return normalCellHeight
//        }
        return 75
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
