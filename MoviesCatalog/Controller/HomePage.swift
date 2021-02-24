//
//  HomePage.swift
//  MoviesCatalog


import UIKit

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = ["Crime", "Adventure", "Science Fiction"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 230
        
        navigationItem.title = "🎬 Cinetesa"
        navigationItem.backButtonTitle = ""
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = categories[section]
        label.font = UIFont (name: "HelveticaNeue-Thin", size: 20)
        label.textColor = UIColor.white
        headerView.addSubview(label)
        
        return headerView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        Collection.chosenSection = indexPath.section
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellOne", for: indexPath) as! CategoriesTableViewCell
            
           // Collection.bridge = Collection.firstSection
            
            cell.didSelectItemAction = { [weak self] indexPath in
                self?.performSegue(withIdentifier: "pushData", sender: self)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellTwo", for: indexPath) as! CategoriesTableViewCell
           
           // Collection.bridge = Collection.secondSection
            
            cell.didSelectItemAction = { [weak self] indexPath in
                self?.performSegue(withIdentifier: "pushData", sender: self)
            }
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellThree", for: indexPath) as! CategoriesTableViewCell
            
           // Collection.bridge = Collection.thirdSection
            
            cell.didSelectItemAction = { [weak self] indexPath in
                self?.performSegue(withIdentifier: "pushData", sender: self)
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    
}
