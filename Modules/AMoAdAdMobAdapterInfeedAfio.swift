//
//  AMoAdAdMobAdapterInfeedAfio.swift
//  AMoAdAdMobDemo
//

import Foundation
import UIKit
import GoogleMobileAds

@objc class AMoAdAdMobAdapterInfeedAfio : NSObject, GADCustomEventBanner, AMoAdNativeAppDelegate {
    
    var delegate: GADCustomEventBannerDelegate?
    
    func requestAd(_ adSize: GADAdSize, parameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        guard let sid = serverParameter else {
            print("Cannot find sid")
            return
        }
        guard let dic = request.additionalParameters else {
            print("Cannot find additionalParameters")
            return
        }
        guard let adView = dic["adView"] as? UIView else {
            print("Cannot find adView")
            return
        }
        initInfeedAfio(sid: sid, adView: adView)
    }
    
    fileprivate func initInfeedAfio(sid: String, adView: UIView) {
        // 広告準備・取得
        AMoAdNativeViewManager.shared().prepareAd(withSid: sid, iconPreloading: true, imagePreloading: true)
        AMoAdNativeViewManager.shared().renderAd(withSid: sid, tag: "", view: adView, coder: nil, delegate: self)
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
        delegate?.customEventBannerWillLeaveApplication(self)
    }
}
