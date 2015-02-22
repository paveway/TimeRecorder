//
//  MessageDialog.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/22.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

/**
出退勤記録
メッセージダイアログ

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
class MessageDialog {
    
    /**
    メッセージダイアログを生成する。
    
    :param: title タイトル
    :param: message メッセージ
    :return: メッセージダイアログ
    */
    class func createMessageDialog(#title: String, message: String) -> UIAlertController {
        Log.v("IN")
        
        let alertController =
            UIAlertController(
                title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        Log.v("OUT(OK)")
        return alertController
    }
}