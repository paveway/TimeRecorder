//
//  DetailViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/01/29.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit

/**
出退勤記録
記録一覧画面

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class RecordDetailViewController: UITableViewController {

    /** ラベル */
    let labels: Array<String> = ["出勤", "退勤"]
    
    /** 時間記録データ(引き継ぎデータ) */
    var timeRecord: TimeRecord?

    /**
    ビューの設定を行う。
    */
    func configureView() {
        Log.d("IN")
        
        if let detail: TimeRecord = self.timeRecord {
        }
        
        Log.d("OUT(OUT)")
    }

    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        Log.d("IN")
      
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        self.configureView()
        
        Log.d("OUT(OUT)")
    }

    /**
    メモリ不足の時に呼び出される。
    */
    override func didReceiveMemoryWarning() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.didReceiveMemoryWarning()
        
        Log.d("OUT(OUT)")
    }
    
    // MARK: - Segues
    
    /**
    画面遷移前に呼び出される。

    :param: segue セグエ
    :param sender 引き継ぎデータ
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        Log.d("IN segue.identifier=[\(segue.identifier)]")
        
        // 入力画面の場合
        if segue.identifier == "showRecordInput" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                (segue.destinationViewController as InputTimeViewController).timeRecord = timeRecord
                (segue.destinationViewController as InputTimeViewController).timeType = indexPath.row
            }
        }
        
        Log.d("OUT(OK)")
    }
    
    // MARK: - Table View
    
    /**
    セクション内の行数を返却する。

    :param: tableView テーブルビュー
    :param: section セクション番号
    :return: セクション内の行数
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Log.d("IN")
        
        Log.d("OUT(OK)")
        return 2
    }
    
    /**
    指定行のセルを返却する。

    :param: tableView テーブルビュー
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        Log.d("IN")
        
        // セルを取得する。
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // ラベル
        cell.textLabel?.text = labels[indexPath.row]
        if indexPath.row == 0 {
            if timeRecord?.enterTime != "" {
                cell.detailTextLabel?.text = timeRecord?.enterTime
            } else {
                cell.detailTextLabel?.text = "未設定"
            }
        
        } else if indexPath.row == 1 {
            if timeRecord?.exitTime != "" {
                cell.detailTextLabel?.text = timeRecord?.exitTime
            } else {
                cell.detailTextLabel?.text = "未設定"
            }
        }
        
        Log.d("OUT(OK)")
        return cell
    }
}

