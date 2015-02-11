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
日付ユーティリティ

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
class DateUtil {
    
    /**
    年の数値を返却する。

    :param: date 年の数値を取得する日付
    :return: 年の数値
    */
    class func year(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: date)
        return comp.year
    }
    
    /**
    月の数値を返却する。
    
    :param: date 月の数値を取得する日付
    :return: 月の数値
    */
    class func month(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
        return comp.month
    }
    
    /**
    日の数値を返却する。
    
    :param: date 日の数値を取得する日付
    :return: 日の数値
    */
    class func day(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: date)
        return comp.day
    }
    
    /**
    曜日の数値を返却する。
    
    :param: date 日の数値を取得する日付
    :return: 日の数値
    */
    class func weekday(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date)
        return comp.weekday
    }
    
    /**
    指定された年月日のNSDateオブジェクトを返却する。
    
    :param: year 年
    :param: month 月
    :param: day 日
    :return: NSDateオブジェクト
    */
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
