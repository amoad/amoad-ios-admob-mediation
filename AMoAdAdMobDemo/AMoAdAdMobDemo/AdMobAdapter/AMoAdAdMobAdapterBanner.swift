//
//  AMoAdAdMobAdapterBanner.swift
//  AMoAdAdMobDemo
//

import Foundation
import UIKit
import GoogleMobileAds

@objc class AMoAdAdMobAdapterBanner : NSObject, GADCustomEventBanner {
    
    var delegate: GADCustomEventBannerDelegate?
    
    func requestAd(_ adSize: GADAdSize, parameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        if let sid = serverParameter { initBanner(sid: sid, size: adSize.size) }
    }
    
    fileprivate func initBanner(sid: String, size: CGSize) {
        if let amoadView = AMoAdView.init() {
            amoadView.frame.size = size
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
//        delegate?.customEventBanner(self, didReceiveAd: amoadView)
    }
    
    func aMoAdViewDidFail(toReceiveAd amoadView: AMoAdView!, error: Error!) {
        print("広告の取得に失敗した（error:\(error)")
        delegate?.customEventBanner(self, didFailAd: nil)
    }
    
    func aMoAdViewDidReceiveEmptyAd(_ amoadView: AMoAdView!) {
        print("空の広告を受信した")
        delegate?.customEventBanner(self, didFailAd: nil)
    }
    
    func aMoAdViewDidClick(_ amoadView: AMoAdView!) {
        print("広告がクリックされた")
        delegate?.customEventBannerWasClicked(self)
        delegate?.customEventBannerWillLeaveApplication(self)
    }
    
    func aMoAdViewWillClickBack(_ amoadView: AMoAdView!) {
        print("広告がクリックされた後、戻ってくる")
    }
    
    func aMoAdViewDidClickBack(_ amoadView: AMoAdView!) {
        print("広告がクリックされた後、戻ってきた")
    }
}
