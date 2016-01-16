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
    var colorOfDay: [Day: UIColor] = [ .Mon: UIColor(netHex:0x7BD33E), .Tue: UIColor(netHex: 0x3DCDCC), .Wed: UIColor(netHex: 0xFD8E62), .Thu: UIColor(netHex: 0xA364D8), .Fri: UIColor(netHex: 0xE2679A), .Sat: UIColor(netHex: 0xF2DA5E), .Sun: UIColor(netHex: 0xEE6E5D)]
    var backgroundColor: UIColor = UIColor(netHex: 0xE7DDD4)
    var fontColor: UIColor = UIColor(netHex: 0x6F6559)
    var fontHightlightColor: UIColor = UIColor(netHex: 0xAB9D89)
    
    var expandedCellPaths: [NSIndexPath] = [NSIndexPath]()
    var normalCellHeight: CGFloat = 76
    var lastSectionIndex: Int = 0
    var sectionSelected: [Bool] = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayOfWeek = [ .Mon, .Tue, .Wed, .Thu, .Fri, .Sat, .Sun]
        sectionSelected = [Bool](count: dayOfWeek.count, repeatedValue: false)
        lastSectionIndex = self.dayOfWeek.count
        totalSpentPerDay = [0, 7.27, 0, 40, 39, 0, 0]
        
        //Set up format
        let headersHeight = CGFloat(dayOfWeek.count*10)
        normalCellHeight = (view.bounds.height - self.navigationController!.navigationBar.bounds.height - 15 - headersHeight)/(CGFloat(self.dayOfWeek.count) + 1)
        
        //Register nibs
//        let summaryCellNib = UINib(nibName: "summaryCell", bundle: nil)
//        tableView.registerNib(summaryCellNib, forCellReuseIdentifier: "summaryCell")
//        let allExpenseNib = UINib(nibName: "allExpenseCell", bundle: nil)
//        tableView.registerNib(allExpenseNib, forCellReuseIdentifier: "allExpenseCell")
        
        //Make seperator brown & skinny
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
        self.tableView.separatorColor = backgroundColor
        
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
        return dayOfWeek.count + 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == lastSectionIndex{
            return 1
        }
        else if (sectionSelected[section]) {
            ///we want the number of people plus the header cell
            return 2 + 1;
        } else {
            ///we just want the header cell
            return 1;
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        } else{
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = backgroundColor
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == lastSectionIndex{
            let lastSectionCell = tableView.dequeueReusableCellWithIdentifier("allExpensesCell") as! AllExpensesCell
            return lastSectionCell
        }
        else if indexPath.row == 0{
            let header = tableView.dequeueReusableCellWithIdentifier("headerCell") as!
            SummaryHeaderTableViewCell
            let day = dayOfWeek[indexPath.section]
            header.dayOfWeek.text = day.rawValue.uppercaseString
            header.dayOfWeek.backgroundColor = colorOfDay[day]
            header.totalCost.text = "$\(totalSpentPerDay[indexPath.section])"
            header.totalCostView.backgroundColor = colorOfDay[day]
            return header
        } else{
            let detail = tableView.dequeueReusableCellWithIdentifier("detailCell") as! SummaryDetailTableViewCell
            let day = dayOfWeek[indexPath.row]
            detail.color.backgroundColor = colorOfDay[day]
            detail.selectedBackgroundView = UIView(frame: CGRect.zero)
            detail.selectedBackgroundView?.backgroundColor = colorOfDay[day]
            detail.category.image = UIImage(named: "General")
            detail.category.tintColor = fontHightlightColor
            detail.category.contentMode = .ScaleAspectFit
            detail.function.text = "Social"
            detail.cost.text = "$5"
            detail.note.text = "noting down stuff okay done blah blah blah..."
            
            return detail
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == lastSectionIndex{
            
        }
        else if (indexPath.row == 0) {
            ///it's the first row of any section so it would be your custom section header
            
            ///put in your code to toggle your boolean value here
            sectionSelected[indexPath.section] = !sectionSelected[indexPath.section];
            
            ///reload this section
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return normalCellHeight
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
