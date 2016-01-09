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

calendar.dateFromComponents(dateComponents)
var dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "EEE HH:mm aa MMM dd, yyy"
let date = dateFormatter.stringFromDate(currentDate)

print("day = \(dateComponents.day)", "month = \(dateComponents.month)", "year = \(dateComponents.year)", "week of year = \(dateComponents.weekOfYear)", "hour = \(dateComponents.hour)", "minute = \(dateComponents.minute)", "second = \(dateComponents.second)", "nanosecond = \(dateComponents.nanosecond)" , separator: ", ", terminator: "")