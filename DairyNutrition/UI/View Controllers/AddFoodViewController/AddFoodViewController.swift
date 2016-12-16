//
//  AddFoodViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-12.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import CoreData
import AlecrimCoreData


class AddFoodViewController: MainViewController, FoodsTableProtocol, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var crabsLabel: UILabel!
    
    @IBOutlet weak var protLabel: UILabel!
    
    @IBOutlet weak var rdiLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var caloriesRemainingLabel: UILabel!
    
    @IBOutlet weak var foodsTableView: UITableView!
    
    @IBOutlet weak var foodsTableHeightContraint: NSLayoutConstraint!
    
    fileprivate private(set) lazy var fetchRequestController: FetchRequestController<CoreFood> = {
        let query = persistentContainer.viewContext.foods.filter{ $0.date == Shared.shared.selectedDate }.orderBy{ $0.name }
        
        print("\(persistentContainer.viewContext.foods.orderBy{ $0.date }.map{ $0.date })")
        
        return query.toFetchRequestController()
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add Food"

        //self.fetchRequestController.bind(to: self.tableView)
        
        self.fetchRequestController.bind(to: self.foodsTableView)
        
        self.setupFoodsTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rowHeight = CGFloat(44)
        let headerHeight = foodsTableView.sectionHeaderHeight
        let count = self.fetchRequestController.numberOfObjects(inSection: 0) == 0 ? 1 : self.fetchRequestController.numberOfObjects(inSection: 0)
        
        let height = (CGFloat(count) * rowHeight) + headerHeight
        self.foodsTableHeightContraint.constant = height
        
        let array = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Energy" }.flatMap{ $0.value }}
        print(sumArray(array: array!))
        //print("\([1...3].reduce(0.0, combine: +))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Custom functions
    
    func setupFoodsTableView() {
        let view = (Bundle.main.loadNibNamed("FoodsTableSectionHeader", owner: self, options: nil)?[0] as? FoodsTableSectionHeader)
        
        self.foodsTableView.tableHeaderView = view
        view?.delegate = self
    }
    
    func pushFoodSearchViewController() {
        super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "FoodSearchViewController"))!)
    }
    
    func sumArray(array: [Double]) -> Double{
        var sum = 0.0
        for element in array {
            sum += element
        }
        return sum
    }
}
    // MARK: - UITableViewDelegate

extension AddFoodViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchRequestController.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchRequestController.numberOfObjects(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodsTableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        let food = self.fetchRequestController.object(at: indexPath)
        
        cell.textLabel!.text = food.name
        cell.detailTextLabel!.text = "\(Int(food.nutrients.filter{ $0.name == "Energy" }[0].value))"
        
        return cell
    }
}
