//
//  Expense.swift
//  Expense
//
//  Created by Monica Ong on 1/7/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

enum Function{
    case Personal, Social, Work, Family
}
enum HeadCategory{
    case General, Personal, House, FoodDrink, Transport, Clothes, Fun, Misc
}
enum Subcategory{
    //General = none
    
    case /*Personal*/Mobile, Medical, Taxes, Insurance, PersonalCare, Gadgets, Pets, Education, Laundry, Fitness, Loan, Vouchers, Subscriptions, /*House*/Groceries, Rent, Phone, Electricity, Internet, Cable, Water, Repairs, Plants, Mortgage, Electronics, Furniture, Heating, /*Food&Drink*/Takeout, Fastfood, DiningOut, Cafe, Drinks, /*Transport also has insurance*/ Gas, Maintenance, PublicTransport, Taxi, CarLoan, Penalty, Flight, Parking, CarRentals, /*Clothes*/Shoes, Clothes, Accessories, Underwear, Bags, /*Fun*/Events, Movies, Recreation, Cultural, Sports, Books, Magazines, Music, Apps, Software, TVShows, /*Misc*/Gift, Office, Charity, Lodging, Service, Toy
}
struct Category {
    var category: HeadCategory
    var subcategory: Subcategory
}

class Expense: NSObject {
    var amountSpent: Double
    
    var date: NSDateComponents
    
//    var function: Function
//    var category: Category
//    
//    var note: String
//    var location: String
//    var receipt: UIImage
    
    init(amountSpent: Double){
        self.amountSpent = amountSpent
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        self.date = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: date)
    }
    
    init(amountSpent: Double, date: NSDate){
        self.amountSpent = amountSpent
        let calendar = NSCalendar.currentCalendar()
                self.date = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: date)

    }
}
