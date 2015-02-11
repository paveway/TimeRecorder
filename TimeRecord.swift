//
//  TimeRecord.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/01/31.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation
import CoreData

/**
出退勤記録
時間記録データ

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
@objc(TimeRecord)
class TimeRecord: NSManagedObject {

    @NSManaged var recordDate: String
    @NSManaged var enterTime: String
    @NSManaged var exitTime: String

}
