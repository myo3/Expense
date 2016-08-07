//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let currentDate = NSDate()
let calendar = NSCalendar.currentCalendar()
let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
dateComponents.month
dateComponents.day
dateComponents.year

dateComponents.hour
dateComponents.minute

let createdDate = dateComponents
calendar.dateFromComponents(dateComponents)
var dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "h:mm"
//"hh:mm aa"//"EEE HH:mm aa MMM dd, yyy"
let date = dateFormatter.stringFromDate(currentDate)

print("day = \(dateComponents.day)", "month = \(dateComponents.month)", "year = \(dateComponents.year)", "week of year = \(dateComponents.weekOfYear)", "hour = \(dateComponents.hour)", "minute = \(dateComponents.minute)", "second = \(dateComponents.second)", "nanosecond = \(dateComponents.nanosecond)" , separator: ", ", terminator: "")

let contents = "5000.80"
let stringArray = contents.componentsSeparatedByString(".")
let string = "80."
let result = string.characters.split{$0 == "."}.map(String.init)
print(result)


struct Number {
    static let formatterWithSepator: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .DecimalStyle
        return formatter
    }()
}
extension IntegerType {
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.stringFromNumber(hashValue) ?? ""
    }
}

let myInt = 2358000
let myIntString = myInt.stringFormatedWithSepator  // "2 358 000"

func stringFormatted(str: String) -> String{
    let formatter = NSNumberFormatter()
    formatter.groupingSeparator = ","
    formatter.numberStyle = .DecimalStyle
    let num = formatter.numberFromString(str)
    return String (num)
}

let newNum = stringFormatted("2356.56")

let fmt = NSNumberFormatter()
fmt.numberStyle = .DecimalStyle
let strFrmNum = fmt.stringFromNumber(1000.58)  // with my locale, "2,358,000"
fmt.locale = NSLocale(localeIdentifier: "fr_FR")
//fmt.numberFromString(strFrmNum)
fmt.stringFromNumber(2358000)  // "2 358 000"

var cost: Double = 58.9
let costInt = Int(cost)
let costtext = "\(cost)"
print(cost)

58.5%10

let costLabel = "58.05"
costLabel.characters.last

let myDouble = Double(costLabel)
