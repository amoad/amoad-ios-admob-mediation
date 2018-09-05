//
//  AMoAdAdMobAdapterInterstitial.swift
//  AMoAdAdMobDemo
//
//  Created by 菅原 清吾 on 2018/08/29.
//  Copyright © 2018年 com.amoad. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class AMoAdAdMobAdapterInterstitial: NSObject, GADCustomEventInterstitial {
    
    var delegate: GADCustomEventInterstitialDelegate?
    var sid: String?
    
    func requestAd(withParameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        AMoAdView.setEnvStaging(true)
        sid = serverParameter
        if let _ = sid { initInterstitial() }
    }
    
    func present(fromRootViewController rootViewController: UIViewController) {
        AMoAdInterstitial.showAd(withSid: sid, completion: { (sid, result, err) in
            switch result {
            case .click:
                print("リンクボタンがクリックされたので閉じました")
            case .close:
                print("閉じるボタンがクリックされたので閉じました")
            case .closeFromApp:
                print("既に開かれているので開きませんでした")
            case .duplicated:
                print("アプリから閉じられました")
            case .failure:
                print("広告の取得に失敗しました:\(String(describing: err))")
            }
        })
    }
    
    fileprivate func initInterstitial() {
        AMoAdInterstitial.registerAd(withSid: sid)
        /// 任意でpropertyの割り当てをしてください。
//        AMoAdInterstitial.setAutoReloadWithSid(sid, autoReload: true)
        AMoAdInterstitial.loadAd(withSid: sid) { (sid, result, err) in
            switch result {
            case .success:
                print("広告ロード成功")
                self.delegate?.customEventInterstitialDidReceiveAd(self)
            case .failure:
                print("広告ロード失敗")
                self.delegate?.customEventInterstitial(self, didFailAd: err)
            case .empty:
                print("配信する広告がない")
                self.delegate?.customEventInterstitial(self, didFailAd: nil)
            }
        }
    }
}
