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
class InputDateViewController: BaseViewController {
    
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
    時間記録データを保存する。
    
    :param: sender
    */
    @IBAction func saveTimeRecord(sender: AnyObject) {
        Log.d("IN")

        // 選択された日付が存在しない場合
        let date = datePicker.date
        if !CoreDataUtil.isExistRecordDate(date) {
            // 時間記録を保存する。
            CoreDataUtil.saveTimeRecord(date)
            
            // 一覧画面に戻る。
            self.navigationController?.popViewControllerAnimated(true)
        
        // 選択された日付が存在する場合
        } else {
            // エラーダイアログを表示する。
            let dialog =
                MessageDialog.createMessageDialog(
                    title: "注意", message: "選択された日付は既に登録済みです。")
            self.presentViewController(dialog, animated: true, completion: nil)
        }
        
        Log.d("OUT(OK)")
    }
}
