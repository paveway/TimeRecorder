//
//  CoreDataUtil.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/22.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation
import CoreData

/**
出退勤記録
CoreDataユーティリティ

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
class CoreDataUtil {
    
    /**
    コンテキストを返却する。
    
    :return: コンテキスト
    */
    class func getManagedObjectContext() -> NSManagedObjectContext {
        // コンテキストを取得する。
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        return managedObjectContext!
    }
    
    /**
    選択された記録年月日が存在するかチェックする。
    
    :return: true 存在する / false 存在しない
    */
    class func isExistRecordDate(date: NSDate) -> Bool {
        Log.d("IN")
        
        // 選択された日付を取得する。
        let date = DateUtil.getDateString(date)
        
        // コンテキストを取得する。
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity =
            NSEntityDescription.entityForName(
                TimeRecord.TIME_RECORD_KEY, inManagedObjectContext: managedObjectContext!)
        let predicate = NSPredicate(format: "\(TimeRecord.RECORD_DATE_KEY)='\(date)'")
        fetchRequest.predicate = predicate
        
        var result = false
        if var results =
            managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) {
                if results.count == 1 {
                    result = true
                }
        }
        
        Log.d("OUT(OK)")
        return result
    }
    
    /**
    時間記録を保存する。
    
    :param: date 対象の日付オブジェクト
    */
    class func saveTimeRecord(date: NSDate) {
        Log.v("IN")
        
        // コンテキストを取得する。
        let managedObjectContext = CoreDataUtil.getManagedObjectContext()
        saveTimeRecord(date, managedObjectContext: managedObjectContext)
        
        Log.v("OUT(OK)")
    }
    
    /**
    時間記録を保存する。
    
    :param: date 対象の日付オブジェクト
    */
    class func saveTimeRecord(date: NSDate, managedObjectContext: NSManagedObjectContext) {
        Log.v("IN")
        
        // 時間記録オブジェクトを取得する。
        let timeRecord =
        NSEntityDescription.insertNewObjectForEntityForName(
            TimeRecord.TIME_RECORD_KEY,
            inManagedObjectContext: managedObjectContext) as NSManagedObject
        
        // 時間記録オブジェクトに新規データを設定する。
        let date = DateUtil.getDateString(date)
        timeRecord.setValue(date, forKey: TimeRecord.RECORD_DATE_KEY)
        timeRecord.setValue("", forKey: TimeRecord.ENTER_TIME_KEY)
        timeRecord.setValue("", forKey: TimeRecord.EXIT_TIME_KEY)
        
        // データを新規登録する。
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
            Log.w("save() error.")
            abort()
        }
        
        Log.v("OUT(OK)")
    }
}