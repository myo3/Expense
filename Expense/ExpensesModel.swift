//
//  ExpensesModel.swift
//  Expense
//
//  Created by Monica Ong on 1/22/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

enum Day: String{
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
}

enum Function: String{
    case Personal, Social, Work, Family
}
enum Category: String{
    case General, Personal, House, Food, Transport, Clothes, Fun, Misc
}
enum Subcategory: String{
    //General = none
    
    case /*General*/None, /*Personal*/Mobile, Medical, Taxes, Insurance, Personal_Care, Gadgets, Pets, Education, Laundry, Fitness, Loan, Vouchers, Subscriptions, /*House*/Groceries, Rent, Phone, Electricity, Internet, Cable, Water, Repairs, Plants, Mortgage, Electronics, Furniture, Heating, /*Food&Drink*/Takeout, Fastfood, Dining_Out, Cafe, Drinks, /*Transport also has insurance*/ Gas, Maintenance, Public_Transport, Taxi, Car_Loan, Penalty, Flight, Parking, Car_Rental, /*Clothes*/Shoes, Clothes, Accessories, Underwear, Bags, /*Fun*/Events, Movies, Recreation, Cultural, Sports, Books, Magazines, Music, Apps, Software, TVShows, /*Misc*/Gift, Office, Charity, Lodging, Service, Toy
}

class ExpensesModel: NSObject {
    
    var Expenses: [Expense] = [Expense]()
    var Subcategories: [Category: [Subcategory]] = [.General: [.None], .Personal: [.Mobile, .Medical, .Taxes, .Insurance, .Personal_Care, .Gadgets, .Pets, .Education, .Laundry, .Fitness, .Loan, .Vouchers, .Subscriptions], .House : [.Groceries, .Rent, .Phone, .Electricity, . Internet, .Cable, .Water, .Repairs, .Plants, .Mortgage, .Electronics, .Furniture, .Heating], .Food : [.Takeout, .Fastfood, .Dining_Out, .Cafe, .Drinks], .Transport : [.Gas, .Maintenance, .Public_Transport, .Taxi, .Insurance, .Car_Loan, .Penalty, .Flight, .Parking, .Car_Rental], .Clothes: [.Shoes, .Clothes, .Accessories, .Underwear,.Bags], .Fun : [.Events, .Movies, .Recreation, .Cultural, .Sports, .Books, .Magazines, .Music, .Apps, .Software, .TVShows], .Misc : [.Gift, .Office, .Charity, .Lodging, .Service, .Toy]]
    
    
}
