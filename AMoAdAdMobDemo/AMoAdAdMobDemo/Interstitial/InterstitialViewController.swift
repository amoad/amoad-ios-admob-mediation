//
//  InterstitialViewController.swift
//  AMoAdAdMobDemo
//
//  Created by 菅原 清吾 on 2018/08/28.
//  Copyright © 2018年 com.amoad. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InterstitialViewController: UIViewController {

    var interstitial: GADInterstitial!
    let adUnitID = "ca-app-pub-6717685917384193/1202555554"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadInterstitial(_ sender: Any) {
        interstitial = createAndLoadInterstitial()
    }
    
    @IBAction func showInterstitial(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Interstitial Ad wasn't ready")
        }
    }
    
    fileprivate func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: adUnitID)
        interstitial.delegate = self
        let gadRequest = GADRequest()
        gadRequest.testDevices = AppData.isSimulator ? [kGADSimulatorID] : [AppData.deviceID]
        interstitial.load(gadRequest)
        return interstitial
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InterstitialViewController: GADInterstitialDelegate {
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        interstitial = createAndLoadInterstitial()
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
