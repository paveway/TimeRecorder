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
    
    /** クラスプロパティ構造体 */
    private struct ClassProperty {
        /** 日付フォーマット */
        static var dateFormat = "yyyy/MM/dd"
        
        /** 時間フォーマット */
        static var timeFormat = "HH:mm"
    }
    
    /** 日付フォーマット定数 */
    class var DATE_FORMAT: String {
        get {
            return ClassProperty.dateFormat
        }
    }
    
    /** 時間フォーマット定数 */
    class var TIME_FORMAT: String {
        get {
            return ClassProperty.timeFormat
        }
    }
    
    /**
    年の数値を返却する。

    :param: date 年の数値を取得する日付
    :return: 年の数値
    */
    class func getYear(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents =
            calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: date)
        return comp.year
    }
    
    /**
    月の数値を返却する。
    
    :param: date 月の数値を取得する日付
    :return: 月の数値
    */
    class func getMonth(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents =
            calendar.components(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
        return comp.month
    }
    
    /**
    日の数値を返却する。
    
    :param: date 日の数値を取得する日付
    :return: 日の数値
    */
    class func getDay(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents =
            calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: date)
        return comp.day
    }
    
    /**
    曜日の数値を返却する。
    
    :param: date 日の数値を取得する日付
    :return: 日の数値
    */
    class func getWeekday(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp: NSDateComponents =
            calendar.components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date)
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
    
    /**
    日付文字列を返却する。

    :param: date 対象の日付オブジェクト
    :return: 日付文字列
    */
    class func getDateString(date: NSDate) -> String {
        Log.v("IN")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: LocaleConstants.LOCALE)
        dateFormatter.dateFormat = DATE_FORMAT
        let result = dateFormatter.stringFromDate(date)
        
        Log.v("OUT(OK)")
        return result
    }
    
    /**
    時間文字列を返却する。
    
    :param: date 対象の日付オブジェクト
    :return: 時間文字列
    */
    class func getTimeString(date: NSDate) -> String {
        Log.v("IN")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: LocaleConstants.LOCALE)
        dateFormatter.dateFormat = TIME_FORMAT
        let result = dateFormatter.stringFromDate(date)
        
        Log.v("OUT(OK) result=[\(result)]")
        return result
    }
}
