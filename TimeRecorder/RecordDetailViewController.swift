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
class RecordDetailViewController: BaseTableViewController {

    /** ラベル */
    let labels: Array<String> = ["出勤", "退勤"]
    
    /** 時間記録データ(引き継ぎデータ) */
    var timeRecord: TimeRecord?

    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        Log.d("IN")
      
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        Log.d("OUT(OUT)")
    }
    
    /**
    ビューが表示される前に呼びだされる。

    :param: animated アニメーション
    */
    override func viewWillAppear(animated: Bool) {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewWillAppear(animated)
        
        // テーブルビューのデータをリロードする。
        self.tableView.reloadData()
        
        Log.d("OUT(OK)")
    }
    
    /**
    ビューが表示された後に呼びだされる。
    
    :param: animated アニメーション
    */
    override func viewDidAppear(animated: Bool) {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewDidAppear(animated)
        
        Log.d("OUT(OK)")
    }
    
    /**
    ビューが非表示になる前に呼びだされる。
    
    :param: animated アニメーション
    */
    override func viewWillDisappear(animated: Bool) {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewWillDisappear(animated)
        
        Log.d("OUT(OK)")
    }
    
    /**
    ビューが非表示になった後に呼びだされる。
    
    :param: animated アニメーション
    */
    override func viewDidDisappear(animated: Bool) {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewDidDisappear(animated)
        
        Log.d("OUT(OK)")
    }
    
    // MARK: - Segues
    
    /**
    画面遷移前に呼び出される。

    :param: segue セグエ
    :param sender 引き継ぎデータ
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        Log.d("IN segue.identifier=[\(segue.identifier)]")
        
        // 時間入力画面の場合
        if segue.identifier == SegueConstants.SHOW_INPUT_TIME {
            // 選択された行のインデックスパスを取得する。
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                // 遷移先画面に引き継ぎデータを設定する。
                let vc = segue.destinationViewController as InputTimeViewController
                vc.timeRecord = timeRecord
                vc.timeType = indexPath.row
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
    override func tableView(
        tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        Log.d("IN")
        
        // セルを取得する。
        let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // セルのラベルをラベル名を設定する。
        cell.textLabel?.text = labels[indexPath.row]
        
        // 0行目の場合
        if indexPath.row == 0 {
            // 出勤時間が入力済みの場合
            if timeRecord?.enterTime != "" {
                // セルの詳細ラベルに出勤時間を設定する。
                cell.detailTextLabel?.text = timeRecord?.enterTime
                
            // 出勤時間が未入力の場合
            } else {
                // セルの詳細ラベルに未設定を設定する。
                cell.detailTextLabel?.text = "未設定"
            }
        
        // 1行目の場合
        } else if indexPath.row == 1 {
            // 退勤時間が入力済みの場合
            if timeRecord?.exitTime != "" {
                // セルの詳細ラベルに退勤時間を設定する。
                cell.detailTextLabel?.text = timeRecord?.exitTime
                
            // 退勤時間が未入力の場合
            } else {
                // セルの詳細ラベルに未設定を設定する。
                cell.detailTextLabel?.text = "未設定"
            }
        }
        
        Log.d("OUT(OK)")
        return cell
    }
}

