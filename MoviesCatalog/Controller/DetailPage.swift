//
//  DetailPage.swift
//  MoviesCatalog


import UIKit
import Alamofire

class DetailPage: UIViewController {
    var detailArray: [Result] = []
     
    
    @IBOutlet weak var filmBanner: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmRating: UILabel!
    @IBOutlet weak var filmReleaseDate: UILabel!
    @IBOutlet weak var filmOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Connectivity.isConnectedToInternet {
            let item = Collection.bridge![Collection.chosenMember]
            var bannerUrl = URL(string: "")
            
            if item.backdropPath != nil {
                bannerUrl = URL(string: "https://image.tmdb.org/t/p/original" + "\(item.backdropPath!)")
            } else {
                bannerUrl = URL(string: "https://image.tmdb.org/t/p/original" + "\(item.posterPath)")
            }
            let imageData = try? Data(contentsOf: bannerUrl!.asURL())
            
            filmBanner.image = UIImage(data: imageData!)
            filmTitle.text = item.title
            filmRating.text = "⭐ \(item.voteAverage ?? 0.0)"
            filmReleaseDate.text = "📅 \(item.releaseDate)"
            filmOverview.text = item.overview
        } else {
            filmBanner.image = UIImage(named: "noInternetConnection")
            filmTitle.text = ""
            filmRating.text = ""
            filmReleaseDate.text = ""
            filmOverview.text = ""
            
            print("no internet connection")
            makeAlertView(alertTitle: "No internet connection", alertMessage: "Please check your internet connection and retry")
        }
        
    }
    
    func makeAlertView(alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            (UIAlertAction) in print("OK button clicked")
        }
        let subView = (alert.view.subviews.first?.subviews.first)! as UIView
        subView.layer.cornerRadius = 10.0
        alert.addAction(okButton)
        alert.view.tintColor = UIColor.purple
        self.present(alert, animated: true, completion: nil)
    }
    
}
