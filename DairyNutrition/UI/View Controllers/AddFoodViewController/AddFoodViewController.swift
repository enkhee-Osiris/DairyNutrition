//
//  AddFoodViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-12.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class AddFoodViewController: MainViewController, FoodsTableViewProtocol {

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
        
//        let header: UIView = UIView() //recast your view as a UITableViewHeaderFooterView
//        header.frame = CGRect(x: 0, y: 0, width: foodsTableView.fs_width, height: 44)
//        header.backgroundColor = UIColor.green //make the background color light blue
//        
//        //header.textLabel?.textColor = UIColor.white //make the text white
//        header.alpha = 0.5 //make the header transparent
//        
//
//        
        //foodsTableView.tableHeaderView = UINib(nibName: "FoodsTableSectionHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
