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

class SummaryTableViewController:  UITableViewController {
    
    var dayOfWeek: [Day] = [Day]()
    var totalSpentPerDay: [Double] = [Double]()
    var colorOfDay: [Day: UIColor] = [ .Mon: UIColor(netHex:0x8AD749), .Tue: UIColor(netHex: 0x33BEB7), .Wed: UIColor(netHex: 0xF6621E), .Thu: UIColor(netHex: 0xA364D8), .Fri: UIColor(netHex: 0xF82927), .Sat: UIColor(netHex: 0xEE6579), .Sun: UIColor(netHex: 0xFECC31)]
    
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
        let summaryCellNib = UINib(nibName: "summaryCell", bundle: nil)
        tableView.registerNib(summaryCellNib, forCellReuseIdentifier: "summaryCell")
        let allExpenseNib = UINib(nibName: "allExpenseCell", bundle: nil)
        tableView.registerNib(allExpenseNib, forCellReuseIdentifier: "allExpenseCell")
        
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dayOfWeek.count + 1//"+1" for the allExpense cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.row == lastCellIndex{
            let cell = tableView.dequeueReusableCellWithIdentifier("allExpenseCell", forIndexPath: indexPath) as! AllExpenseCell
            
            return cell
        }else{
            //Create day of week cell
            let cell = tableView.dequeueReusableCellWithIdentifier("summaryCell", forIndexPath: indexPath) as! SummaryCell
            let day = dayOfWeek[indexPath.row]
            
            cell.dayOfWeek.text = day.rawValue.uppercaseString
            cell.dayOfWeek.backgroundColor = colorOfDay[day]
            
            cell.totalAmountSpent.text = "$\(totalSpentPerDay[indexPath.row])"
            cell.totalAmountSpent.backgroundColor = colorOfDay[day]
            cell.totalAmountSpentView.backgroundColor = colorOfDay[day]
            
            cell.heightOfMainView.constant = normalCellHeight
            
            cell.selectionStyle = .None
            return cell
        }
        
        cell.selectionStyle = .None
        return cell

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != lastCellIndex{
            if expandedCellPaths.contains(indexPath){
                let index = expandedCellPaths.indexOf(indexPath)
                expandedCellPaths.removeAtIndex(index!)
            }else{
                expandedCellPaths.append(indexPath)
            }
            
            //old trick to animate cell expand/collapse
            tableView.beginUpdates()
            tableView.endUpdates()
        }


        print("Row \(indexPath.row) selected")
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != lastCellIndex{
            let expandedCellHeight = normalCellHeight*2
            if expandedCellPaths.contains(indexPath){
                return expandedCellHeight
            }else{
                return normalCellHeight
            }
        } else{
            return normalCellHeight
        }
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
