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
class InputTimeViewController: BaseViewController {
    
    /** 時間記録データ(引き継ぎデータ) */
    var timeRecord: TimeRecord?
    
    /**
    時間タイプ
    
    - 0:出勤
    - 1:退勤
    */
    var timeType: Int?
    
    /** 時間選択 */
    @IBOutlet weak var timePicker: UIDatePicker!

    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // 時間選択を設定する。
        timePicker.date = NSDate()
        timePicker.datePickerMode = .Time
        timePicker.minuteInterval = 5
        
        Log.d("OUT(OK)")
    }
    
    /**
    時間記録データを保存する。

    :param: sender バーボタンアイテム
    */
    @IBAction func saveTimeRecord(sender: UIBarButtonItem) {
        Log.d("IN")
      
        // 選択された時間を取得する。
        let time = DateUtil.getTimeString(timePicker.date)
        
        // 時間タイプにより選択された時間を設定する。
        timeType == 0 ? (timeRecord?.enterTime = time) : (timeRecord?.exitTime = time)
        
        // 時間記録データを更新する。
        self.timeRecord?.managedObjectContext!.save(nil)
        
        // 詳細画面に戻る。
        self.navigationController?.popViewControllerAnimated(true)
        
        Log.d("OUT(OK)")
    }
}
