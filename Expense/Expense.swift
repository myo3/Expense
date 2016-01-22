//
//  Expense.swift
//  Expense
//
//  Created by Monica Ong on 1/7/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class Expense: NSObject {
    var cost: Double
    var date: NSDateComponents
    
    var function: Function
    var category: Category
    var subcategory: Subcategory

//    var note: String
//    var location: String
//    var receipt: UIImage
    

    init(amountSpent: Double, date: NSDate){
        self.cost = amountSpent
        //set date
        let calendar = NSCalendar.currentCalendar()
        self.date = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: date)
        //set organization
        self.function = .Personal
        self.category = .General
        self.subcategory = .None
    }
    
    convenience init(amountSpent: Double){
        self.init(amountSpent: amountSpent, date: NSDate()) //set to today's date
    }
    
    init(amountSpent: Double, date: NSDate, function: Function, category: Category, subcategory: Subcategory){
        self.cost = amountSpent
        //set date
        let calendar = NSCalendar.currentCalendar()
        self.date = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: date)
        //set organization
        self.function = function
        self.category = category
        self.subcategory = subcategory
    }
}
