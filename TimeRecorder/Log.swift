//
//  Logger.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/01.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

/**
ログユーティリティ

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
class Log {

    /** ログレベル列挙子 */
    enum LogLevel: Int {
        /** 指定なし */
        case NONE
        
        /** デバッグ */
        case DEBUG
        
        /** インフォ */
        case INFO
        
        /** 警告 */
        case WARN
        
        /** エラー */
        case ERROR
    }
    
    /** ログレベル */
    class var level: Int {
        return LogLevel.DEBUG.hashValue
    }
    
    /**
    デバッグレベルのログを出力する。

    :param: message メッセージ
    :param: function 関数名
    :param: file ファイル名
    :param: 行番号
    */
    class func d(
        message: String,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
            if level >= LogLevel.DEBUG.hashValue {
                Log.write("[DEBUG]", message: message, function: function, file: file, line: line)
            }
    }
    
    /**
    インフォレベルのログを出力する。
    
    :param: message メッセージ
    :param: function 関数名
    :param: file ファイル名
    :param: 行番号
    */
    class func i(
        message: String,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
            if level >= LogLevel.INFO.hashValue {
                Log.write("[INFO]", message: message, function: function, file: file, line: line)
            }
    }
    
    /**
    インフォレベルのログを出力する。
    
    :param: message メッセージ
    :param: function 関数名
    :param: file ファイル名
    :param: 行番号
    */
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
    
    // MARK: - Internal Method
    
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