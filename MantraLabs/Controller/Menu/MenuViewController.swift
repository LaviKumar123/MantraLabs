//
//  MenuViewController.swift
//  MantraLabs
//
//  Created by APPLE on 25/02/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var menuTableView: UITableView!

    //MARK:- Variables
    var categories = [Category]()
    var selectedSectionArr = [Int]()
    
    //MARK:- Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.menuTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        self.loadMenuJson()
    }

    func loadMenuJson() {
        if let path = Bundle.main.path(forResource: "menu", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let jsonDecoder = JSONDecoder()
                self.categories = try jsonDecoder.decode([Category].self, from: data)
                self.menuTableView.reloadData()
              } catch {
                   // handle error
              }
        }
    }
}


//MARK:- Table View Delegate And Data Source
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoryView = CategoryView.loadView()
        categoryView.categoryNameLabel.text = self.categories[section].name ?? ""
        
        let selectedSectionFilter = self.selectedSectionArr.filter({$0 == section})
        
        categoryView.upDownArrow.image = (selectedSectionFilter.count > 0) ? #imageLiteral(resourceName: "arrow-up") : #imageLiteral(resourceName: "arrow-down")
        
        categoryView.completion = { (action) in
            if categoryView.upDownArrow.image == #imageLiteral(resourceName: "arrow-up"){
                let sectionIndex = self.selectedSectionArr.firstIndex(of: section)
                self.selectedSectionArr.remove(at: sectionIndex!)
                categoryView.upDownArrow.image = #imageLiteral(resourceName: "arrow-down")
            }else {
                self.selectedSectionArr.append(section)
                categoryView.upDownArrow.image = #imageLiteral(resourceName: "arrow-up")
            }
            tableView.reloadData()
        }
        return categoryView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subCategories = self.categories[section].sub_category{
            let selectedSectionFilter = self.selectedSectionArr.filter({$0 == section})
            if (selectedSectionFilter.count > 0){
//               let index = self.selectedSectionArr.firstIndex(of: section)
                return subCategories.count
            }else {
                return 0
            }
            
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        if let subCategories = self.categories[indexPath.section].sub_category{
            let subCategory = subCategories[indexPath.row]
            cell.subCategoryLabel.text = subCategory.name
            cell.descriptionLabel.text = subCategory.display_name
        }
        
        return cell
    }
}
