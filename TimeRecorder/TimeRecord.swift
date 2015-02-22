//
//  TimeRecord.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/01/31.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation
import CoreData

/**
出退勤記録
時間記録データ

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
@objc(TimeRecord)
class TimeRecord: NSManagedObject {

    /** クラスプロパティ構造体 */
    private struct ClassProperty {
        /** 時間記録キー */
        static let timeRecordKey = "TimeRecord"
        
        /** 記録年月日キー */
        static let recordDateKey = "recordDate"
        
        /** 出勤時間キー */
        static let enterTimeKey = "enterTime"
        
        /** 退勤時間キー */
        static let exitTimeKey = "exitTime"
    }
    
    /** 時間記録キー定数 */
    class var TIME_RECORD_KEY: String {
        get {
            return ClassProperty.timeRecordKey
        }
    }
    
    /** 記録年月日キー定数 */
    class var RECORD_DATE_KEY: String {
        get {
            return ClassProperty.recordDateKey
        }
    }
    
    /** 出勤時間キー定数 */
    class var ENTER_TIME_KEY: String {
        get {
            return ClassProperty.enterTimeKey
        }
    }
    
    /** 退勤時間キー定数 */
    class var EXIT_TIME_KEY: String {
        get {
            return ClassProperty.exitTimeKey
        }
    }
    
    /** 記録年月日 */
    @NSManaged var recordDate: String
    
    /** 出勤時間 */
    @NSManaged var enterTime: String
    
    /** 退勤時間 */
    @NSManaged var exitTime: String
}
