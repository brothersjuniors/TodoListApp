//
//  AdMobHelper.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2023/01/14.
//

import Foundation
import GoogleMobileAds
 
class AdMobHelper: NSObject {
 
    static let shared = AdMobHelper()
 
    func initSDK() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
 
    func setupBannerAd(adBaseView: UIView, rootVC: UIViewController) {
        let adView = GADBannerView(adSize: GADAdSizeBanner)
        #if DEBUG
        adView.adUnitID = "ca-app-pub-8096571252242204/1666464561"
        #else
        if rootVC is ViewController {
            adView.adUnitID = "ca-app-pub-8096571252242204/1666464561"
    
        }
        #endif
        adView.rootViewController = rootVC
        adView.load(GADRequest())
        adBaseView.addSubview(adView)
        adView.translatesAutoresizingMaskIntoConstraints = false
        adView.centerXAnchor.constraint(equalTo: adBaseView.centerXAnchor).isActive = true
        adView.centerYAnchor.constraint(equalTo: adBaseView.centerYAnchor).isActive = true
        adView.widthAnchor.constraint(equalToConstant: 320.0).isActive = true
        adView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
 
}
