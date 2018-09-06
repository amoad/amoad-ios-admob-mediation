//
//  InfeedAfioViewController.swift
//  AMoAdAdMobDemo
//

import UIKit
import GoogleMobileAds

class InfeedAfioViewController: UIViewController {

    var infeedAfio: GADBannerView!
    let adUnitID = "ca-app-pub-6717685917384193/5006294535"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        infeedAfio = createAndLoadInfeedAfio()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func createAndLoadInfeedAfio() -> GADBannerView {
        infeedAfio = GADBannerView()
        infeedAfio.frame = view.frame
        infeedAfio.delegate = self
        infeedAfio.adUnitID = adUnitID
        infeedAfio.rootViewController = self
        let gadRequest = GADRequest()
        gadRequest.testDevices = AppData.isSimulator ? [kGADSimulatorID] : [AppData.deviceID]
        infeedAfio.load(gadRequest)
        return infeedAfio
    }
    
    fileprivate func addInfeedAfioToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .width,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .width,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .height,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerY,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerY,
                                multiplier: 1,
                                constant: 0)
            ]
        )
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

extension InfeedAfioViewController: GADBannerViewDelegate {
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        addInfeedAfioToView(bannerView)
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

