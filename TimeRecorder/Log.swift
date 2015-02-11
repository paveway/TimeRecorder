//
//  Logger.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/01.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

class Log {

    enum LogLevel: Int {
        case NONE
        case DEBUG
        case INFO
        case WARN
        case ERROR
    }
    
    class var level: Int {
        return LogLevel.DEBUG.hashValue
    }
    
    class func d(
        message: String,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
            if level >= LogLevel.DEBUG.hashValue {
                Log.write("[DEBUG]", message: message, function: function, file: file, line: line)
            }
    }
    
    class func i(
        message: String,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
            if level >= LogLevel.INFO.hashValue {
                Log.write("[INFO]", message: message, function: function, file: file, line: line)
            }
    }
    
    class func w(
        message: String,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
            if level >= LogLevel.WARN.hashValue {
                Log.write("[WARN]", message: message, function: function, file: file, line: line)
            }
    }
    
    class func e(
        message: String,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
            if level >= LogLevel.ERROR.hashValue {
                Log.write("[ERROR]", message: message, function: function, file: file, line: line)
            }
    }
    
    private class func write(
        logLevel: String,
        message: String,
        function: String,
        file: String,
        line: Int) {

        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .MediumStyle
        var dateStr = dateFormatter.stringFromDate(NSDate())

        var fileName = file
        if let match = fileName.rangeOfString("[^/]*$", options: .RegularExpressionSearch) {
            fileName = fileName.substringWithRange(match)
        }
        println("\(logLevel) \(dateStr) \(fileName)#\(function)[\(line)] \(message)")
    }
}