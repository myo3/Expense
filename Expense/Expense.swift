//
//  Expense.swift
//  Expense
//
//  Created by Monica Ong on 1/7/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

enum Function: String{
    case Personal, Social, Work, Family
}
enum Category: String{
    case General, Personal, House, Food, Transport, Clothes, Fun, Misc
}
enum Subcategory: String{
    //General = none
    
    case /*General*/None, /*Personal*/Mobile, Medical, Taxes, Insurance, PersonalCare, Gadgets, Pets, Education, Laundry, Fitness, Loan, Vouchers, Subscriptions, /*House*/Groceries, Rent, Phone, Electricity, Internet, Cable, Water, Repairs, Plants, Mortgage, Electronics, Furniture, Heating, /*Food&Drink*/Takeout, Fastfood, DiningOut, Cafe, Drinks, /*Transport also has insurance*/ Gas, Maintenance, PublicTransport, Taxi, CarLoan, Penalty, Flight, Parking, CarRentals, /*Clothes*/Shoes, Clothes, Accessories, Underwear, Bags, /*Fun*/Events, Movies, Recreation, Cultural, Sports, Books, Magazines, Music, Apps, Software, TVShows, /*Misc*/Gift, Office, Charity, Lodging, Service, Toy
}

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
