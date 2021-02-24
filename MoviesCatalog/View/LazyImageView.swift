//
//  LazyImageView.swift
//  MoviesCatalog


import Foundation
import UIKit

class LazyImageView: UIImageView {
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(fromURL imageURL: URL, placeHolderImage: String){
        self.image = UIImage(named: placeHolderImage)
        
        if let dictionary = UserDefaults.standard.object( forKey: "ImageCache") as? [String: String] {
            if let path = dictionary["\(imageURL)"] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    let image = UIImage(data: data)
                    self.image = image
                    return
                }
                
            }
        }
        
        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try? Data(contentsOf: imageURL)
            {
                debugPrint("image downloaded from server")
                if let image = UIImage(data: imageData)
                {
                    DispatchQueue.main.async {
                        let path = NSTemporaryDirectory().appending(UUID().uuidString)
                        let url = URL(fileURLWithPath: path)
                        
                        let data = image.jpegData(compressionQuality: 0.5)
                        try? data?.write(to: url)
                        
                        var dictionary = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]
                        if dictionary == nil {
                            dictionary = [String: String]()
                        }
                        
                        dictionary!["\(imageURL)"] = path
                        UserDefaults.standard.set(dictionary, forKey: "ImageCache")
                        self?.image = image
                        
                    }
                }
            }
        }
    }
}

