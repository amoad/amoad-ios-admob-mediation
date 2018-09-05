//
//  AMoAdAdMobAdapterInfeedAfio.swift
//  AMoAdAdMobDemo
//

import Foundation
import UIKit
import GoogleMobileAds

class AMoAdAdMobAdapterInfeedAfio : NSObject, GADCustomEventBanner, AMoAdNativeAppDelegate {
    
    var delegate: GADCustomEventBannerDelegate?
    
    func requestAd(_ adSize: GADAdSize, parameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        AMoAdNativeViewManager.shared().setEnvStaging(true)
        if let parameter = serverParameter {
            if let customEventData = AMoAdAdMobUtil.extractInfeedAfioCustomEventData(parameter: parameter) {
                initInfeedAfio(sid: customEventData.sid, file:customEventData.file, size: adSize.size)
            }
        }
    }
    
    fileprivate func initInfeedAfio(sid: String, file: String, size: CGSize) {
        
        // 広告 View を xib から生成する
        let view = Bundle.main.loadNibNamed(file, owner: nil, options: nil)?.first as! UIView
        view.frame.size = size
        
        // 広告準備
        AMoAdNativeViewManager.shared().prepareAd(withSid: sid, iconPreloading: true, imagePreloading: true)
        
        // 広告取得
        AMoAdNativeViewManager.shared().renderAd(withSid: sid, tag: "", view: view, coder: nil, delegate: self)
    }
}

extension AMoAdAdMobAdapterInfeedAfio {
    
    func amoadNativeDidReceive(_ sid: String!, tag: String!, view: UIView!, state: AMoAdResult) {
        switch state {
        case .success:
            print("広告ロード成功")
            delegate?.customEventBanner(self, didReceiveAd: view)
        case .failure:
            print("広告ロード失敗")
            delegate?.customEventBanner(self, didFailAd: nil)
        case .empty:
            print("配信する広告がない")
            delegate?.customEventBanner(self, didFailAd: nil)
        }
    }
    
    func amoadNativeIconDidReceive(_ sid: String!, tag: String!, view: UIView!, state: AMoAdResult) {
        switch state {
        case .success:
            print("アイコン取得成功")
        case .failure:
            print("アイコン取得失敗")
        case .empty:
            print("配信するアイコンがない")
        }
    }
    
    func amoadNativeImageDidReceive(_ sid: String!, tag: String!, view: UIView!, state: AMoAdResult) {
        switch state {
        case .success:
            print("メイン画像取得成功")
        case .failure:
            print("メイン画像取得失敗")
        case .empty:
            print("配信するメイン画像がない")
        }
    }
    
    func amoadNativeDidClick(_ sid: String!, tag: String!, view: UIView!) {
        print("広告クリック")
        delegate?.customEventBannerWasClicked(self)
    }
}
