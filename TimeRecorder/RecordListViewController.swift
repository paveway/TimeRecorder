//
//  MasterViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/01/29.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit
import CoreData

/**
出退勤記録
記録一覧画面

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class RecordListViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    /** コンテキスト */
    var managedObjectContext: NSManagedObjectContext? = nil

    /**
    nibファイルロード後に呼び出される。
    */
    override func awakeFromNib() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.awakeFromNib()
        
        Log.d("OUT(OK)")
    }

    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        Log.d("IN")

        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
    
        // 左上に編集ボタンを設定する。
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        // 右上に追加ボタンを設定する。
        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton
        
        Log.d("OUT(OK)")
    }

    /**
    メモリ不足の時に呼び出される。
    */
    override func didReceiveMemoryWarning() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.didReceiveMemoryWarning()
        
        Log.d("OUT(OK)")
    }

    /**
    当日の日付文字列を返却する。

    :return: 当日の日付文字列
    */
    func getToday() -> String {
        Log.d("IN")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let result = dateFormatter.stringFromDate(NSDate())
        
        Log.d("OUT(OK) result=[\(result)]")
        return result
    }
    
    /**
    当日が存在するかチェックする。
    
    :return: true 当日が存在する / false 存在しない
    */
    func isExistToday() -> Bool {
        Log.d("IN")
        
        let today = getToday()
        
        let context = self.fetchedResultsController.managedObjectContext
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = self.fetchedResultsController.fetchRequest.entity!
        //let now = NSDate()
        //let day = DateUtil.date(DateUtil.year(now), month:DateUtil.month(now), day:DateUtil.day(now))
        let predicate = NSPredicate(format: "recordDate='\(today)'")
        fetchRequest.predicate = predicate
        
        var result = false
        if var results = context.executeFetchRequest(fetchRequest, error: nil) {
            if results.count == 1 {
                result = true
            }
        }
        
        Log.d("OUT(OK)")
        return result
    }
    
    /**
    新しいオブジェクトを新規挿入する。

    :param: sender
    */
    func insertNewObject(sender: AnyObject) {
        Log.d("IN")
        
        let vc: InputDateViewController = InputDateViewController()
        //let vc: RecordInputViewController = RecordInputViewController()
        self.navigationController?.pushViewController(vc, animated: true)
/*
        // 存在しない日の場合
        if !isExistToday() {
            // コンテキストを取得する。
            let context = self.fetchedResultsController.managedObjectContext
            
            // エンティティを取得する。
            let entity = self.fetchedResultsController.fetchRequest.entity!
            
            // 新規タイムレコードオブジェクトを取得する。
            let timeRecord = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as NSManagedObject

            // タイムレコードオブジェクトにデータを設定する。
            let today = getToday()
            timeRecord.setValue(today, forKey: "recordDate")
            timeRecord.setValue("", forKey: "enterTime")
            timeRecord.setValue("", forKey: "exitTime")
            
            // データを新規登録する。
            var error: NSError? = nil
            if !context.save(&error) {
                Log.w("save() error.")
                abort()
            }
        }
*/
        
        Log.d("OUT(OK)")
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "結果", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        //let alertController = UIAlertController(nibName: "DatePickerViewController", bundle: nil)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        Log.d("IN segue.identifier=[\(segue.identifier)]")
        
        // 詳細画面の場合
        if segue.identifier == "showRecordDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let timeRecord = self.fetchedResultsController.objectAtIndexPath(indexPath) as TimeRecord
                (segue.destinationViewController as RecordDetailViewController).timeRecord = timeRecord
            }
        } else if segue.identifier == "showInputDate" {
            
        } else if segue.identifier == "showEditDate" {
            
        }
        
        Log.d("OUT(OK)")
    }

    // MARK: - Table View

    /**
    セクション数を返却する。

    :param: tableView テーブルビュー
    :return: セクション数
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        Log.d("IN")
        Log.d("OUT(OK)")
        return self.fetchedResultsController.sections?.count ?? 0
    }

    /**
    セクション内の行数を返却する。

    :param: tableView テーブルビュー
    :param numberOfRowsInSection セクション番号
    :return: セクション内の行数
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Log.d("IN")
        
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        
        Log.d("OUT(OK)")
        return sectionInfo.numberOfObjects
    }

    /**
    指定行のセルを返却する。

    :param: テーブルビュー
    :param: cellForRowAtIndexPath 指定行
    :return: セル
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        Log.d("IN")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        
        Log.d("OUT(OK)")
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        Log.d("IN")
        
        Log.d("OUT(OK)")
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        Log.d("IN")
        
        Log.d("editingStyle=[\(editingStyle)]")
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
                
            var error: NSError? = nil
            if !context.save(&error) {
                Log.w("save() error.")
                abort()
            }
        }
        
        Log.d("OUT(OK)")
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        Log.d("IN")
        
        let timeRecord = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
        let recordDate = timeRecord.valueForKey("recordDate")!.description
        cell.textLabel!.text = recordDate
        var enterTime = timeRecord.valueForKey("enterTime")!.description
        var exitTime = timeRecord.valueForKey("exitTime")!.description
        enterTime = enterTime != "" ? enterTime : "未設定"
        exitTime = exitTime != "" ? exitTime : "未設定"
        let detail = enterTime + "-" + exitTime
        cell.detailTextLabel!.text = detail
        
        Log.d("OUT(OK)")
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        Log.d("IN")
        
        if _fetchedResultsController != nil {
            Log.d("OUT(OK)")
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("TimeRecord", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "recordDate", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
    	var error: NSError? = nil
    	if !_fetchedResultsController!.performFetch(&error) {
    	     Log.w("preformFetch() error.")
    	     abort()
    	}
        
        Log.d("OUT(OK)")
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        Log.d("IN")
        
        self.tableView.beginUpdates()
        
        Log.d("OUT(OK)")
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        Log.d("IN type=[\(type.rawValue)]")
        
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                Log.w("OUT(NG)")
                return
        }
        
        Log.d("OUT(OK)")
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        Log.d("IN \(type.rawValue)")
        
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            default:
                Log.w("OUT(NG)")
                return
        }
        
        Log.d("OUT(OK)")
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        Log.d("IN")
        
        self.tableView.endUpdates()
        
        Log.d("OUT(OK)")
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

