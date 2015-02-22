//
//  BaseTableViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/22.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit

/**
出退勤記録
基底テーブルビューコントローラ

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class BaseTableViewController: UITableViewController, GADBannerViewDelegate {
    
    /** バナービュー */
    var bannerView: GADBannerView? = nil
    
    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // テーブルビューとスクロールビューの下部にバナービューの表示領域を確保する。
        let insets = UIEdgeInsetsMake(0, 0, BannerUtil.BANNER_HEIGHT, 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
        
        // バナービューを生成し、ビューに追加する。
        bannerView = BannerUtil.createBannerViewForTableView(self, delegate: self)
        self.view.addSubview(bannerView!)
        
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
    スクロールビューがスクロールした時に呼び出される。
    
    :param: scrollView スクロールビュー
    */
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        Log.d("IN")
        
        // バナービューのフレームを取得する。
        var bannerFrame = bannerView!.frame
        
        // バナービューのフレームの縦方向位置を調整する。
        bannerFrame.origin.y =
            self.view.frame.size.height -
            BannerUtil.BANNER_HEIGHT +
            self.tableView.contentOffset.y
        
        // バナービューのフレームを変更する。
        bannerView!.frame = bannerFrame
        
        Log.d("OUT(OK)")
    }
}