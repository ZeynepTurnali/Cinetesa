//
//  LazyImageView.swift
//  MoviesCatalog


import Foundation
import UIKit

class LazyImageView: UIImageView{
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(fromURL imageURL: URL, placeHolderImage: String){
        self.image = UIImage(named: placeHolderImage)
        
        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject){
            debugPrint("Image loaded from cache for: \(imageURL)")
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try? Data(contentsOf: imageURL)
            {
                debugPrint("image downloaded from server")
                if let image = UIImage(data: imageData)
                {
                    DispatchQueue.main.async {
                        self!.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }

}
