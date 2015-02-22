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
class EditDateViewController: BaseViewController {
   
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
    時間記録データを更新する。
    
    :param: sender
    */
    @IBAction func updateTimeRecord(sender: AnyObject) {
        Log.d("IN")
        
        // 選択された記録年月日が存在しない場合
        let date = datePicker.date
        if !CoreDataUtil.isExistRecordDate(date) {
            // コンテキストを取得する。
            let managedObjectContext = CoreDataUtil.getManagedObjectContext()
        
            // 既存の時間記録データを削除する。
            managedObjectContext.deleteObject(timeRecord!)
            
            // 時間記録オブジェクトに新規データを設定する。
            CoreDataUtil.saveTimeRecord(date, managedObjectContext: managedObjectContext)
            
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
