//
//  CategoriesTableViewCell.swift
//  MoviesCatalog


import UIKit
import Alamofire


class CategoriesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var didSelectItemAction: ((IndexPath) -> Void)?
    
    var count = 0
    
    var firstSection : [Result]? = []
    var secondSection : [Result]? = []
    var thirdSection: [Result]? = []
    var selectedSection = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DataStore.getFilmsByGenresAndPages(pagination: true, page: 1, genreId: Sections.crime.rawValue) { movies in
            Collection.firstSection = movies
            self.firstSection = movies
        }
        
        DataStore.getFilmsByGenresAndPages(pagination: true, page: 1, genreId: Sections.adventure.rawValue) { movies in
            Collection.secondSection = movies
            self.secondSection = movies
        }
        
        DataStore.getFilmsByGenresAndPages(pagination: true, page: 1, genreId: Sections.scienceFiction.rawValue) { movies in
            Collection.thirdSection = movies
            self.thirdSection = movies
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            count = firstSection!.count * Collection.scrollFirst
        } else if collectionView.tag == 1 {
            count = secondSection!.count * Collection.scrollSecond
        } else if collectionView.tag == 2 {
            count = thirdSection!.count * Collection.scrollThird
        } else {
            count = 0
        }
        return count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let firstItem = Collection.firstSection![indexPath.row % Collection.firstSection!.count]
        let first_imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + "\(firstItem.posterPath)")!
        if collectionView.tag == 0 {
            cell.filmImage.loadImage(fromURL: first_imageUrl, placeHolderImage: "lazyLoadingImage")
        }
        
        let secondItem = Collection.secondSection![indexPath.row % Collection.secondSection!.count]
        let second_imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + "\(secondItem.posterPath)")!
        if collectionView.tag == 1 {
            cell.filmImage.loadImage(fromURL: second_imageUrl, placeHolderImage: "lazyLoadingImage")
        }
        
        let thirdItem = Collection.thirdSection![indexPath.row % Collection.thirdSection!.count]
        let third_imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + "\(thirdItem.posterPath)")!
        if collectionView.tag == 2 {
            cell.filmImage.loadImage(fromURL: third_imageUrl, placeHolderImage: "lazyLoadingImage")
        }
        
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Collection.chosenMember = indexPath.row
        
        if collectionView.tag == 0 {
            Collection.bridge = Collection.firstSection
        } else if collectionView.tag == 1 {
            Collection.bridge = Collection.secondSection
        } else if collectionView.tag == 2 {
            Collection.bridge = Collection.thirdSection
        }
        didSelectItemAction?(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.x
        
        if position > collectionView.contentSize.width - scrollView.frame.size.width - 20 {
            guard !DataStore.isPaginating else {
                // already called
                return
            }
            // sleep(3)
            if collectionView.tag == 0 {
                DataStore.getFilmsByGenresAndPages(pagination: true, page: Collection.scrollFirst + 1, genreId: Sections.crime.rawValue) { movies in
                    Collection.scrollFirst += 1
                    self.firstSection = self.firstSection! + movies
                    Collection.firstSection = self.firstSection
                    
                }
            } else if collectionView.tag == 1 {
                DataStore.getFilmsByGenresAndPages(pagination: true, page: Collection.scrollSecond + 1, genreId: Sections.adventure.rawValue) { movies in
                    Collection.scrollSecond += 1
                    self.secondSection = self.secondSection! + movies
                    Collection.secondSection = self.secondSection
                }
            } else if collectionView.tag == 2 {
                DataStore.getFilmsByGenresAndPages(pagination: true, page: Collection.scrollThird + 1, genreId: Sections.scienceFiction.rawValue) { movies in
                    Collection.scrollThird += 1
                    self.thirdSection = self.thirdSection! + movies
                    Collection.thirdSection = self.thirdSection
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
}





