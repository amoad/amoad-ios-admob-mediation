//
//  AMoAdAdMobAdapterBanner.swift
//  AMoAdAdMobDemo
//
//  Created by 菅原 清吾 on 2018/08/28.
//  Copyright © 2018年 com.amoad. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class AMoAdAdMobAdapterBanner : NSObject, GADCustomEventBanner {
    
    var delegate: GADCustomEventBannerDelegate?
    
    func requestAd(_ adSize: GADAdSize, parameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        AMoAdView.setEnvStaging(true)
        if let sid = serverParameter { initBanner(sid: sid, size: adSize.size) }
    }
    
    fileprivate func initBanner(sid: String, size: CGSize) {
        if let amoadView = AMoAdView.init(frame: CGRect(x : 0, y : 0, width : size.width, height : size.height)) {
            amoadView.delegate = self
            /// 任意でpropertyの割り当てをしてください。
//            amoadView.horizontalAlign = .center
//            amoadView.verticalAlign = .bottom
//            amoadView.rotateTransition = .flipFromLeft
//            amoadView.clickTransition = .jump
            amoadView.sid = sid
            delegate?.customEventBanner(self, didReceiveAd: amoadView)
        }
    }
}

extension AMoAdAdMobAdapterBanner : AMoAdViewDelegate {
    
    func aMoAdViewDidReceiveAd(_ amoadView: AMoAdView!) {
        print("正常に広告を受信した")
        delegate?.customEventBanner(self, didReceiveAd: amoadView)
    }
    
    func aMoAdViewDidFail(toReceiveAd amoadView: AMoAdView!, error: Error!) {
        print("広告の取得に失敗した（error:\(error)）")
        delegate?.customEventBanner(self, didFailAd: error)
    }
    
    func aMoAdViewDidReceiveEmptyAd(_ amoadView: AMoAdView!) {
        print("空の広告を受信した")
        delegate?.customEventBanner(self, didFailAd: nil)
    }
    
    func aMoAdViewDidClick(_ amoadView: AMoAdView!) {
        print("広告がクリックされた")
        delegate?.customEventBannerWasClicked(self)
    }
    
    func aMoAdViewWillClickBack(_ amoadView: AMoAdView!) {
        print("広告がクリックされた後、戻ってくる")
    }
    
    func aMoAdViewDidClickBack(_ amoadView: AMoAdView!) {
        print("広告がクリックされた後、戻ってきた")
    }
}
