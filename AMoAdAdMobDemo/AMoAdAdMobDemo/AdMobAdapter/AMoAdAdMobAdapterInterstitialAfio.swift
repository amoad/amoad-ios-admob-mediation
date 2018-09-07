//
//  AMoAdAdMobAdapterInterstitialAfio.swift
//  AMoAdAdMobDemo
//

import Foundation
import UIKit
import GoogleMobileAds

@objc class AMoAdAdMobAdapterInterstitialAfio: NSObject, GADCustomEventInterstitial {
    
    var delegate: GADCustomEventInterstitialDelegate?
    var sid: String?
    
    func requestAd(withParameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        AMoAdNativeViewManager.shared().setEnvStaging(true)
        sid = serverParameter
        if let _ = sid { initInterstitialAfio() }
    }
    
    func present(fromRootViewController rootViewController: UIViewController) {
        if AMoAdInterstitialVideo.sharedInstance(withSid: sid, tag: "").isLoaded {
            AMoAdInterstitialVideo.sharedInstance(withSid: sid, tag: "").show()
        } else {
            print("Interstitial Afio Ad wasn't loaded")
        }
    }

    fileprivate func initInterstitialAfio() {
        AMoAdInterstitialVideo.sharedInstance(withSid: sid, tag: "").delegate = self
        /// 任意でpropertyの割り当てをしてください。
//        AMoAdInterstitialVideo.sharedInstance(withSid: sid, tag: "").isCancellable = false
        AMoAdInterstitialVideo.sharedInstance(withSid: sid, tag: "").load()
    }
}

extension AMoAdAdMobAdapterInterstitialAfio : AMoAdInterstitialVideoDelegate {
    
    func amoadInterstitialVideo(_ amoadInterstitialVideo: AMoAdInterstitialVideo!, didLoadAd result: AMoAdResult) {
        switch result {
        case .success:
            print("広告ロード成功")
            self.delegate?.customEventInterstitialDidReceiveAd(self)
        case .failure:
            print("広告ロード失敗")
            self.delegate?.customEventInterstitial(self, didFailAd: nil)
        case .empty:
            print("配信する広告がない")
            self.delegate?.customEventInterstitial(self, didFailAd: nil)
        }
    }
    
    func amoadInterstitialVideoDidStart(_ amoadInterstitialVideo: AMoAdInterstitialVideo!) {
        print("動画の再生を開始した")
    }
    func amoadInterstitialVideoDidComplete(_ amoadInterstitialVideo: AMoAdInterstitialVideo!) {
        print("動画を最後まで再生完了した")
    }
    func amoadInterstitialVideoDidFailToPlay(_ amoadInterstitialVideo: AMoAdInterstitialVideo!) {
        print("動画の再生に失敗した")
    }
    func amoadInterstitialVideoDidShow(_ amoadInterstitialVideo: AMoAdInterstitialVideo!) {
        print("広告を表示した")
    }
    func amoadInterstitialVideoWillDismiss(_ amoadInterstitialVideo: AMoAdInterstitialVideo!) {
        print("広告を閉じた")
        self.delegate?.customEventInterstitialWillDismiss(self)
        self.delegate?.customEventInterstitialDidDismiss(self)
    }
    func amoadInterstitialVideoDidClickAd(_ amoadInterstitialVideo: AMoAdInterstitialVideo!) {
        print("広告がクリックされた")
        self.delegate?.customEventInterstitialWasClicked(self)
        self.delegate?.customEventInterstitialWillLeaveApplication(self)
    }
}
