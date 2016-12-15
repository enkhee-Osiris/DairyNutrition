//
//  AddFoodViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-12.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class AddFoodViewController: MainViewController, FoodsTableProtocol {

    // MARK: Properties
    
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var crabsLabel: UILabel!
    
    @IBOutlet weak var protLabel: UILabel!
    
    @IBOutlet weak var rdiLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var caloriesRemainingLabel: UILabel!
    
    @IBOutlet weak var foodsTableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add Food"

        self.setupFoodsTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Custom functions
    
    func setupFoodsTableView() {
        let view = (Bundle.main.loadNibNamed("FoodsTableSectionHeader", owner: self, options: nil)?[0] as? FoodsTableSectionHeader)
        foodsTableView.tableHeaderView = view
        view?.delegate = self
    }
    
    func pushFoodSearchViewController() {
        super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "FoodSearchViewController"))!)
    }
}
