//
//  BaseViewController.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/22.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit

/**
出退勤記録
基底ビューコントローラ

:version: 1.0 新規作成
:since: 1.0
:author: paveway.info@gmail.com
*/
class BaseViewController: UIViewController, GADBannerViewDelegate {
    
    /** バナービュー */
    var bannerView: GADBannerView? = nil
    
    /**
    ビューがロードされた時に呼び出される。
    */
    override func viewDidLoad() {
        Log.d("IN")
        
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // バナービューを生成し、ビューに追加する。
        bannerView = BannerUtil.createBannerViewForNormalView(self, delegate: self)
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
}
