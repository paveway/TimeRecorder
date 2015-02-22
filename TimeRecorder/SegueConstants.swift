//
//  SegueConstants.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/22.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

/**
出退勤記録
セグエ定数

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
class SegueConstants {
    
    /** クラスプロパティ構造体 */
    private struct ClassProperty {
        /** 詳細画面 */
        static let showRecordDetail = "showRecordDetail"
        
        /** 日付入力画面 */
        static let showInputDate = "showInputDate"
        
        /** 日付編集画面 */
        static let showEditDate = "showEditDate"
        
        /** 時間入力画面 */
        static let showInputTime = "showInputTime"
    }
    
    /** 詳細画面定数 */
    class var SHOW_RECORD_DETAIL: String {
        get {
            return ClassProperty.showRecordDetail
        }
    }
    
    /** 日付入力画面定数 */
    class var SHOW_INPUT_DATE: String {
        get {
            return ClassProperty.showInputDate
        }
    }
    
    /** 日付編集画面定数 */
    class var SHOW_EDIT_DATE: String {
        get {
            return ClassProperty.showEditDate
        }
    }
    
    /** 時間入力画面定数 */
    class var SHOW_INPUT_TIME: String {
        get {
            return ClassProperty.showInputTime
        }
    }
}