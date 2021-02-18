//
//  DataStore.swift
//  MoviesCatalog


import Foundation
import Alamofire

class DataStore {
    
    let pageNumber = ""
    let genreId = ""
    
    func getFilmsByGenres(){
        
        let params = ["api_key":"daf9f9e3d071bcb9d8028262fb015b8a", "language":"en-US","sort_by":"popularity.desc","include_adult":"false", "page": pageNumber, "with_genres":  genreId]
        let filmListBaseUrl = "https://api.themoviedb.org/3/discover/movie"
        
        let request = AF.request(filmListBaseUrl, method: .get, parameters: params).validate()
        request.responseJSON { (myData) in
            
            print(myData)
            
            if (myData.response?.statusCode == 200){
                let filmList = try? JSONDecoder().decode(Movie.self, from: myData.data!)
                print(filmList!)
                print(filmList!.results[0].originalTitle)
                
                
            }
            
        }
    }
    
}
