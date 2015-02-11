//
//  InputRecordViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/08.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit

/**
出退勤記録
時間入力画面

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class InputTimeViewController: UIViewController {
    
    /** 時間記録データ(引き継ぎデータ) */
    var timeRecord: TimeRecord?
    
    /**
    時間タイプ
    
    - 0:出勤
    - 1:退勤
    */
    var timeType: Int?
    
    /** 時間入力ピッカー */
    @IBOutlet weak var timePicker: UIDatePicker!

    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // 右上に保存ボタンを設定する。
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveHandler:")
        self.navigationItem.rightBarButtonItem = addButton
        
        timePicker.date = NSDate()
        timePicker.datePickerMode = .Time
        timePicker.minuteInterval = 5
    }
    
    /**
    メモリ不足の時に呼び出される。
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func saveHandler(sender: UIBarButtonItem) {
        let result = getTime(timePicker.date)
        timeType == 0 ? (timeRecord?.enterTime = result) : (timeRecord?.exitTime = result)
        self.timeRecord?.managedObjectContext!.save(nil)
    }
    
    func getTime(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "HH:mm"
        let result = dateFormatter.stringFromDate(date)
        return result
    }
}
