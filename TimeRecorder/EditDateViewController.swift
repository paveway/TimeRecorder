//
//  EditDateViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/11.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit
import CoreData

/**
出退勤記録
日付編集画面

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class EditDateViewController: UIViewController {
   
    /** 時間記録データ(引き継ぎデータ) */
    var timeRecord: TimeRecord?
    
    /** 日付選択 */
    @IBOutlet weak var datePicker: UIDatePicker!

    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        Log.d("OUT(OK)")
    }
    
    /**
    メモリ不足の時に呼び出される。
    */
    override func didReceiveMemoryWarning() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.didReceiveMemoryWarning()
        
        Log.d("OUT(OK)")
    }
    
    // MARK: - Internal Method
    
    /**
    選択された日付文字列を返却する。
    
    :return: 選択された日付文字列
    */
    func getSelectedDate() -> String {
        Log.d("IN")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let result = dateFormatter.stringFromDate(datePicker.date)
        
        Log.d("OUT(OK) result=[\(result)]")
        return result
    }
    
    /**
    時間記録データを更新する。
    
    :param: sender
    */
    @IBAction func updateTimeRecord(sender: AnyObject) {
        Log.d("IN")
        
        // コンテキストを取得する。
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        
        // 既存の時間記録データを削除する。
        managedObjectContext?.deleteObject(timeRecord!)
        
        // 時間記録オブジェクトを取得する。
        let newTimeRecord =
            NSEntityDescription.insertNewObjectForEntityForName(
                "TimeRecord", inManagedObjectContext: managedObjectContext!) as NSManagedObject
            
        // 時間記録オブジェクトに新規データを設定する。
        let date = getSelectedDate()
        newTimeRecord.setValue(date, forKey: "recordDate")
        newTimeRecord.setValue("", forKey: "enterTime")
        newTimeRecord.setValue("", forKey: "exitTime")
            
        // データを新規登録する。
        var error: NSError? = nil
        if !managedObjectContext!.save(&error) {
            Log.w("save() error.")
            abort()
        }
        
        Log.d("OUT(OK)")
    }
}
