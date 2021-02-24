//
//  SplashScreen.swift
//  MoviesCatalog


import UIKit
import SwiftyGif


class SplashScreen: UIViewController, SwiftyGifDelegate {
    @IBOutlet weak var splashGif: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashGif.delegate = self
        
        do {
            let gif = try UIImage(gifName: "splash.gif")
            self.splashGif.setGifImage(gif, loopCount: 1)
        } catch {
            print(error)
        }
    }
    
    func gifDidStop(sender: UIImageView) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homePage")
        self.view.window?.rootViewController = vc
    }
    
}


