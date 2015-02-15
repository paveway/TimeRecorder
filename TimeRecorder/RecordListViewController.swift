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
    
    /** アクセサリボタンインデックスパス */
    var accessoryButtonIndexPath: NSIndexPath? = nil

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
    
        // 左上に削除ボタンを設定する。
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
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
    ビューが表示された時に呼び出される。
    
    :param: animated アニメーション有無の
    */
    override func viewDidAppear(animated: Bool) {
        // アクセサリボタンのインデックスパスをクリアする。
        accessoryButtonIndexPath = nil
    }
    
    // MARK: - Segues

    /**
    画面遷移する前に呼び出される。

    :param: segue セグエ
    :param: sender 引き継ぎデータ
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        Log.d("IN segue.identifier=[\(segue.identifier)]")
        
        // 詳細画面の場合
        if segue.identifier == "showRecordDetail" {
            // 選択された行のインデックスパスが取得できた場合
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                // 対象行の時間記録データを取得する。
                let timeRecord = self.fetchedResultsController.objectAtIndexPath(indexPath) as TimeRecord
                
                // 遷移先画面に時間記録データを設定する。
                (segue.destinationViewController as RecordDetailViewController).timeRecord = timeRecord
            }
        
        // 日付入力画面の場合
        } else if segue.identifier == "showInputDate" {
            
        // 日付編集画面の場合
        } else if segue.identifier == "showEditDate" {
            if accessoryButtonIndexPath != nil {
                Log.d("accessoryButtonIndexPath.row=[\(accessoryButtonIndexPath!.row)]")
                let timeRecord = self.fetchedResultsController.objectAtIndexPath(accessoryButtonIndexPath!) as TimeRecord
                (segue.destinationViewController as EditDateViewController).timeRecord = timeRecord
            }
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
        
        let result = self.fetchedResultsController.sections?.count ?? 0
        
        Log.d("OUT(OK) result=[\(result)]")
        return result
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
        
        let result = sectionInfo.numberOfObjects
        Log.d("OUT(OK) result=[\(result)]")
        return result
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
    
    /**
    アクセサリボタンがタップされた時に呼び出される。

    :param: tableView テーブルビュー
    :param: indexPath インデックスパス
    */
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        Log.d("IN")
        
        // インデックスパスを保存する。
        accessoryButtonIndexPath = indexPath
        
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
        let sortDescriptor = NSSortDescriptor(key: "recordDate", ascending: true)
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

