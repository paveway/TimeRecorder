//
//  InputDateViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/10.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit
import CoreData

/**
出退勤記録
日付入力画面

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class InputDateViewController: UIViewController {
    
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
    選択された日付が存在するかチェックする。
    
    :return: true 存在する / false 存在しない
    */
    func isExistDate() -> Bool {
        Log.d("IN")
        
        // 選択された日付を取得する。
        let date = getSelectedDate()
        
        // コンテキストを取得する。
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity =
            NSEntityDescription.entityForName("TimeRecord", inManagedObjectContext: managedObjectContext!)
        let predicate = NSPredicate(format: "recordDate='\(date)'")
        fetchRequest.predicate = predicate
        
        var result = false
        if var results = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) {
            if results.count == 1 {
                result = true
            }
        }
        
        Log.d("OUT(OK)")
        return result
    }
    
    /**
    時間記録データを保存する。
    
    :param: sender
    */
    @IBAction func saveTimeRecord(sender: AnyObject) {
        Log.d("IN")

        // 選択された日付が存在しない場合
        if !isExistDate() {
            // コンテキストを取得する。
            let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            let managedObjectContext = appDelegate.managedObjectContext
            
            // 時間記録オブジェクトを取得する。
            let timeRecord = NSEntityDescription.insertNewObjectForEntityForName("TimeRecord", inManagedObjectContext: managedObjectContext!) as NSManagedObject
            
            // 時間記録オブジェクトに新規データを設定する。
            let date = getSelectedDate()
            timeRecord.setValue(date, forKey: "recordDate")
            timeRecord.setValue("", forKey: "enterTime")
            timeRecord.setValue("", forKey: "exitTime")
        
            // データを新規登録する。
            var error: NSError? = nil
            if !managedObjectContext!.save(&error) {
                Log.w("save() error.")
                abort()
            }
        } else {
            showMessageDialog(title: "注意", message: "選択された日付は既に登録済みです。")
        }
        
        Log.d("OUT(OK)")
    }
    
    /**
    メッセージダイアログを表示する。
    */
    func showMessageDialog(#title: String, message: String) {
        Log.d("IN")
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        Log.d("OUT(OK)")
    }
}
