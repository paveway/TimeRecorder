//
//  InputDateViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/10.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit

/**
出退勤記録
日付入力画面

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class InputDateViewController: UIViewController {
    
    /** 時間記録データ(引き継ぎデータ) */
    var timeRecord: TimeRecord?
    
    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
    }
    
    /**
    メモリ不足の時に呼び出される。
    */
    override func didReceiveMemoryWarning() {
        // スーパークラスのメソッドを呼び出す。
        super.didReceiveMemoryWarning()
    }
}
