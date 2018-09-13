//
//  AMoAdAdMobAdapterInterstitial.swift
//  AMoAdAdMobDemo
//

import Foundation
import UIKit
import GoogleMobileAds

@objc class AMoAdAdMobAdapterInterstitial: NSObject, GADCustomEventInterstitial {
    
    var delegate: GADCustomEventInterstitialDelegate?
    var sid: String?
    
    func requestAd(withParameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        if let sid = serverParameter {
            self.sid = sid
            initInterstitial()
        }
    }
    
    func present(fromRootViewController rootViewController: UIViewController) {
        if AMoAdInterstitial.isLoadedAd(withSid: sid) {
            self.delegate?.customEventInterstitialWillPresent(self)
            AMoAdInterstitial.showAd(withSid: sid, completion: { (sid, result, err) in
                switch result {
                case .click:
                    print("リンクボタンがクリックされたので閉じました")
                    self.delegate?.customEventInterstitialWasClicked(self)
                    self.delegate?.customEventInterstitialWillLeaveApplication(self)
                    self.delegate?.customEventInterstitialWillDismiss(self)
                    self.delegate?.customEventInterstitialDidDismiss(self)
                case .close:
                    print("閉じるボタンがクリックされたので閉じました")
                    self.delegate?.customEventInterstitialWillDismiss(self)
                    self.delegate?.customEventInterstitialDidDismiss(self)
                case .closeFromApp:
                    print("アプリから閉じられました")
                    self.delegate?.customEventInterstitialWillDismiss(self)
                    self.delegate?.customEventInterstitialDidDismiss(self)
                case .duplicated:
                    print("既に開かれているので開きませんでした")
                case .failure:
                    print("広告の取得に失敗しました:\(String(describing: err))")
                    self.delegate?.customEventInterstitial(self, didFailAd: nil)
                }
            })
        } else {
            print("Interstitial Ad wasn't loaded")
        }
    }
    
    fileprivate func initInterstitial() {
        AMoAdInterstitial.registerAd(withSid: sid)
        //        AMoAdInterstitial.setAutoReloadWithSid(sid, autoReload: false) // 任意でautoReloadの割り当てをしてください。
        AMoAdInterstitial.loadAd(withSid: sid) { (sid, result, err) in
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
    }
}
