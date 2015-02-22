//
//  BannerUtil.swift
//  TimeRecorder
//
//  Created by Masatsugu Futamata on 2015/02/22.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit

/**
出退勤記録
バナービューユーティリティ

:version: 1.0 新規作成
:since: 1.0
:author: mfuta1971@gmail.com
*/
class BannerUtil {
    
    /** クラスプロパティ構造体 */
    private struct ClassProperty {
        /** ADユニットID */
        static let adUnitId = "ca-app-pub-6984834494761648/8520001015"
        
        /** バナー高さ */
        static let bannerHeight = CGSizeFromGADAdSize(kGADAdSizeBanner).height
    }
    
    /** ADユニットID定数 */
    class var AD_UNIT_ID: String {
        get {
            return ClassProperty.adUnitId
        }
    }
    
    /** バナー高さ定数 */
    class var BANNER_HEIGHT: CGFloat {
        get {
            return ClassProperty.bannerHeight
        }
    }
    
    /**
    バナービューを生成する。
    
    :param: viewController ビューコントローラー
    :param: delegate デリゲート
    :return: バナービュー
    */
    class func createBannerViewForNormalView(
        viewController: UIViewController, delegate: GADBannerViewDelegate) -> GADBannerView {
        Log.v("IN")
        
        // テーブルビュー用のバナービュー生成メッドを呼び出す。
        var bannerView =
            createBannerViewForTableView(viewController, delegate: delegate)
    
        // 表示位置を設定する。
        bannerView.frame.origin =
            CGPointMake(0, viewController.view.frame.size.height - BannerUtil.BANNER_HEIGHT)
            
        // 表示サイズを設定する。
        bannerView.frame.size =
            CGSizeMake(viewController.view.frame.size.width, BannerUtil.BANNER_HEIGHT)
        
        Log.v("OUT(OK)")
        return bannerView
    }
    
    /**
    テーブルビュー用のバナービューを生成する。
    
    :param: viewController ビューコントローラー
    :param: delegate デリゲート
    :return: バナービュー
    */
    class func createBannerViewForTableView(
        viewController: UIViewController, delegate: GADBannerViewDelegate) -> GADBannerView {
        Log.v("IN")
            
        // バナービューを生成する。
        var bannerView = GADBannerView()
        
        // サイズを設定する。
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            
        // ADユニットIDを設定する。
        bannerView.adUnitID = BannerUtil.AD_UNIT_ID
            
        // デリゲートを設定する。
        bannerView.delegate = delegate
            
        // ルートビューコントローラを設定する。
        bannerView.rootViewController = viewController
        
        // リクエストを生成し、バナービューに設定する。
        var request = GADRequest()
        request.testDevices = ["GAD_SIMULATOR_ID"]
        bannerView.loadRequest(request)
        
        Log.v("OUT(OK)")
        return bannerView
    }
}