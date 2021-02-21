//
//  DetailPage.swift
//  MoviesCatalog


import UIKit

class DetailPage: UIViewController {
    var detailArray: [Result] = []
     
    
    @IBOutlet weak var filmBanner: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmRating: UILabel!
    @IBOutlet weak var filmReleaseDate: UILabel!
    @IBOutlet weak var filmOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = Collection.bridge![Collection.chosenMember]
        let bannerUrl = URL(string: "https://image.tmdb.org/t/p/w500" + "\(item.backdropPath)")
        let imageData = try? Data(contentsOf: bannerUrl!.asURL())
        
        filmBanner.image = UIImage(data: imageData!)
        filmTitle.text = item.title
        filmRating.text = "⭐ \(item.voteAverage)"
        filmReleaseDate.text = "📅 \(item.releaseDate)"
        filmOverview.text = item.overview
        
    }
    
    
}
