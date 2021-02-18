//
//  CategoriesTableViewCell.swift
//  MoviesCatalog


import UIKit

class CategoriesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellOne", for: indexPath) as? CollectionViewCell {
            cell.filmImage.image = UIImage(named: "pikachu")
            return cell
        } else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellTwo", for: indexPath) as? CollectionViewCell {
            cell.backgroundColor = .white
            return cell
        } else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellThree", for: indexPath) as? CollectionViewCell {
            cell.backgroundColor = .blue
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
