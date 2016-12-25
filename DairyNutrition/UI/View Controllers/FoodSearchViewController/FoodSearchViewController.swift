//
//  FoodSearchViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodSearchViewController: MainViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var tblSearchResults: UITableView!
    
    var customSearchBar: CustomSearchBar!
    
    var dataArray = [String]()
    
    var filteredArray = [String]()
    
    var shouldShowSearchResults = false
    
    @IBOutlet weak var tblSearchResultsTopConstraint: NSLayoutConstraint!
    
    var jsonObj: JSON! = [:]
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        
        self.configureCustomSearchBar()
        self.navigationItem.title =  Shared.shared.selectedDate
        
        super.showLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadListOfCountries(){ finished in
            if finished {
                self.tblSearchResults.reloadData()
                super.stopLoading()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: UITableView Delegate and Datasource functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = indexPath as NSIndexPath
        let row = indexPath.row
        
        let foodInfoViewController = UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "FoodDetailsViewController") as! FoodDetailsViewController
        
        if shouldShowSearchResults {
            let index = dataArray.indexes(of: filteredArray[row])
            foodInfoViewController.foodId = jsonObj[index]["id"].string!
        }
        else {
            foodInfoViewController.foodId = jsonObj[row]["id"].string!
        }
        
        super.pushVC(foodInfoViewController)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        
        let indexPath = indexPath as NSIndexPath
        let row = indexPath.row
        
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredArray[row]
        }
        else {
            cell.textLabel?.text = dataArray[row]
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    

    // MARK: Custom functions
    
    func loadListOfCountries(completion: @escaping (_ finished: Bool) -> ()) {
        // Specify the path to the countries list file.
        //let pathToFile = Bundle.main.path(forResource: "countries", ofType: "txt")
        
        if let path = Bundle.main.path(forResource: "foods", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    dataArray = jsonObj.arrayValue.map({$0["name"].string!})
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        completion(true)
    }
    
    func configureCustomSearchBar() {
        
        self.configureSearchBar(CGRect(x: 0.0,
                                       y: 0.0,
                                       width: self.view.frame.size.width,
                                       height: 50.0),
                                font: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightLight),
                                textColor: UIColor.white,
                                bgColor: pinkColor!)
        
        customSearchBar.placeholder = "Search food..."
        //tblSearchResults.tableHeaderView = customSearchController.customSearchBar
        
        self.view.addSubview(self.customSearchBar)
        self.tblSearchResultsTopConstraint.constant = 50.0
    }

    func configureSearchBar(_ frame: CGRect, font: UIFont, textColor: UIColor, bgColor: UIColor) {
        customSearchBar = CustomSearchBar(frame: frame, font: font , textColor: textColor)
        
        customSearchBar.barTintColor = bgColor
        customSearchBar.tintColor = textColor
        customSearchBar.showsBookmarkButton = false
        customSearchBar.showsCancelButton = true
        
        customSearchBar.delegate = self
    }
    
    
    
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.didStartSearching()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.didTapOnCancelButton()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.didTapOnSearchButton()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.didChangeSearchText(searchText)
    }

    
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (food) -> Bool in
            let foodText:NSString = food as NSString
            
            return (foodText.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }   

    
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        customSearchBar.resignFirstResponder()
        tblSearchResults.reloadData()
    }
    
    
    func didChangeSearchText(_ searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (food) -> Bool in
            let foodText: NSString = food as NSString
            
            return (foodText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }
    
    
}
