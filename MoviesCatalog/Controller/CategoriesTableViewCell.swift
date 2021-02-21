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
    
    var detail = DetailPage()
    var firstPageNumber = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DataStore.getFilmsByGenresAndPages(page: 1, genreId: 80) { movies in
            Collection.firstSection = movies
            self.firstSection = movies
        }
        
        
        DataStore.getFilmsByGenresAndPages(page: 1, genreId: 12) { movies in
            Collection.secondSection = movies
            self.secondSection = movies
        }
        
        
        DataStore.getFilmsByGenresAndPages(page: 2, genreId: 80) { movies in
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            count = firstSection!.count * firstPageNumber
        } else if collectionView.tag == 1 {
            count = secondSection!.count
        } else if collectionView.tag == 2 {
            count = thirdSection!.count
        } else {
            count = 0
        }
        return count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let firstItem = firstSection![indexPath.row]
        let first_imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + "\(firstItem.posterPath)")!
      //  let first_data = try? Data(contentsOf: first_imageUrl.asURL())
        
        let secondItem = secondSection![indexPath.row]
        let second_imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + "\(secondItem.posterPath)")!
      //  let second_data = try? Data(contentsOf: second_imageUrl.asURL())
        
        let thirdItem = thirdSection![indexPath.row]
        let third_imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + "\(thirdItem.posterPath)")!
      //  let third_data = try? Data(contentsOf: third_imageUrl.asURL())
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        if collectionView.tag == 0 {
            cell.filmImage.loadImage(fromURL: first_imageUrl, placeHolderImage: "lazyLoadingImage")
           // cell.filmImage.image = UIImage(data: first_data!)
        } else if collectionView.tag == 1 {
           // cell.filmImage.image = UIImage(data: second_data!)
            cell.filmImage.loadImage(fromURL: second_imageUrl, placeHolderImage: "lazyLoadingImage")
        } else if collectionView.tag == 2 {
            cell.filmImage.loadImage(fromURL: third_imageUrl, placeHolderImage: "lazyLoadingImage")
          // cell.filmImage.image = UIImage(data: third_data!)
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
        didSelectItemAction?(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.x
        if position > collectionView.contentSize.width - scrollView.frame.size.width - 20 {
            print("called")
            DataStore.getFilmsByGenresAndPages(page: firstPageNumber + 1, genreId: 80) { movies in
                Collection.firstSection = movies
                self.firstSection = self.firstSection! + movies
                self.firstPageNumber += 1
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
//            let pageInt = Int(round(pageFloat))
//
//            switch pageInt {
//            case 0:
//                collectionView.scrollToItem(at: [0, 20], at: .left, animated: false)
//            case firstSection!.count - 1:
//                collectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
//            default:
//                break
//            }
//        }
}





