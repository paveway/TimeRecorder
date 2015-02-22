//
//  LocaleConstants.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/22.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

class LocaleConstants {
    
    /** クラスプロパティ構造体 */
    private struct ClassProperty {
        /** ロケール */
        static var locale = "ja_JP"
    }
    
    /** ロケール定数 */
    class var LOCALE: String {
        get {
            return ClassProperty.locale
        }
    }
}