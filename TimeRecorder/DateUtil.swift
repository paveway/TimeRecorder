//
//  DateUtil.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/06.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

/**
出退勤記録
日付

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
class DateUtil {
    
    class func year(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: date)
        return comp.year
    }
    
    class func month(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
        return comp.month
    }
    
    class func day(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: date)
        return comp.day
    }
    
    class func weekday(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date)
        return comp.weekday
    }
    
    class func date(year: Int, month: Int, day: Int) -> NSDate {
        var comp = NSDateComponents()
        comp.year = year
        comp.month = month
        comp.day = day
        var cal = NSCalendar.currentCalendar()
        var date = cal.dateFromComponents(comp)
        return date!
    }
}
