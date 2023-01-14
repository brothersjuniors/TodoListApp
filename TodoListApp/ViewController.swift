//
//  ViewController.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2023/01/11.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController, GADFullScreenContentDelegate {
   
    @IBOutlet var adBaseView: GADBannerView!
    
  //  var bannerView: GADBannerView!
    var AdMobBannerId: String {
            return Bundle.main.object(forInfoDictionaryKey: "GADApplicationIdentifier") as! String
        }
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    private var interstitial: GADInterstitialAd?
    override func viewDidLoad() {
        super.viewDidLoad()
        AdMobHelper.shared.setupBannerAd(adBaseView: self.adBaseView, rootVC: self)
        setAd()
        // インスタンス化
        adBaseView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.size.width))
            // メソッド呼び出し
        addBannerViewToView(adBaseView, view: adBaseView)

            adBaseView.adUnitID = "ca-app-pub-8096571252242204/1666464561"
            adBaseView.rootViewController = self
            // 広告読み込み
            adBaseView.load(GADRequest())
        }
        
 
func addBannerViewToView(_ bannerView: GADBannerView,view:UIView) {
     bannerView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(bannerView)
     view.addConstraints(
         [NSLayoutConstraint(item: bannerView,
                             attribute: .bottom,
                             relatedBy: .equal,
                             toItem:  view.safeAreaLayoutGuide,
                             attribute: .bottom,
                             multiplier: 1,
                             constant: 0),
          NSLayoutConstraint(item: bannerView,
                             attribute: .centerX,
                             relatedBy: .equal,
                             toItem: view,
                             attribute: .centerX,
                             multiplier: 1,
                             constant: 0)
         ])
 }

 
    func setAd(){
        interstitial?.fullScreenContentDelegate = self
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-8096571252242204/3828420012",request: request,completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        })
    
    }

    @IBAction func buttons(_ sender: Any) {
        if self.interstitial != nil {
                   self.interstitial?.present(fromRootViewController: self)
               } else {
                   print("Ad wasn't ready")
               }
    
           }
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.performSegue(withIdentifier: "toMain", sender: nil)
    }

}
