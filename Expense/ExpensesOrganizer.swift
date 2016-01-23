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
    
    case /*General*/None, /*Personal*/Mobile, Medical, Taxes, Insurance, Personal_Care, Gadgets, Pets, Education, Laundry, Fitness, Loan, Vouchers, Subscriptions, /*House*/Groceries, Rent, Phone, Electricity, Internet, Cable, Water, Repairs, Plants, Mortgage, Electronics, Furniture, Heating, /*Food&Drink*/Takeout, Fastfood, Dining_Out, Cafe, Drinks, /*Transport also has insurance*/ Gas, Maintenance, Public_Transport, Taxi, Car_Loan, Penalty, Flight, Parking, Car_Rental, /*Clothes*/Shoes, Clothes, Accessories, Underwear, Bags, /*Fun*/Events, Movies, Recreation, Cultural, Sports, Books, Magazines, Music, Apps, Software, TV_Shows, /*Misc*/Gift, Office, Charity, Lodging, Service, Toy
}

class ExpensesOrganizer: NSObject {
    
    private var expenses: [Expense] = [Expense]()
    private var functions: [Function] = [.Personal, .Social, .Work, .Family]
    private var categories: [Category] = [.General, .Personal, .House, .Food, .Transport, .Clothes, .Fun, .Misc]
    private var subcategories: [Category: [Subcategory]] = [.General: [.None], .Personal: [.Mobile, .Medical, .Taxes, .Insurance, .Personal_Care, .Gadgets, .Pets, .Education, .Laundry, .Fitness, .Loan, .Vouchers, .Subscriptions], .House : [.Groceries, .Rent, .Phone, .Electricity, . Internet, .Cable, .Water, .Repairs, .Plants, .Mortgage, .Electronics, .Furniture, .Heating], .Food : [.Takeout, .Fastfood, .Dining_Out, .Cafe, .Drinks], .Transport : [.Gas, .Maintenance, .Public_Transport, .Taxi, .Insurance, .Car_Loan, .Penalty, .Flight, .Parking, .Car_Rental], .Clothes: [.Shoes, .Clothes, .Accessories, .Underwear,.Bags], .Fun : [.Events, .Movies, .Recreation, .Cultural, .Sports, .Books, .Magazines, .Music, .Apps, .Software, .TV_Shows], .Misc : [.Gift, .Office, .Charity, .Lodging, .Service, .Toy]]
    
    //get count functions
    func getNumOfFunctions() -> Int{
        return functions.count
    }
    
    func getNumOfCategories() -> Int{
        return categories.count
    }
    
    func getNumOfSubcategoriesFor(category: Category) -> Int{
        return (subcategories[category]?.count)!
    }
    
    //get list functions
    func getAllFunctions() -> [Function]{
        return functions
    }
    
    func getAllCategories() -> [Category]{
        return categories
    }
    
    func getSubcategoriesFor(category: Category) -> [Subcategory]{
        return subcategories[category]!
    }
    
    //get list element at index function
    func getFunction(index: Int) -> Function{
        return functions[index]
    }
    
    func getCategory(index: Int) -> Category{
        return categories[index]
    }
    
    func getSubcategoryFor(category: Category, index: Int) -> Subcategory{
        let subcategoryList = subcategories[category]!
        return subcategoryList[index]
    }
    
    func getText(string: String) -> String{
        return string.stringByReplacingOccurrencesOfString("_", withString: " ")
    }
}
