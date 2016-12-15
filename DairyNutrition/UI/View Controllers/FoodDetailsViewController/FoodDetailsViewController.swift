//
//  FoodDetailsViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class FoodDetailsViewController: MainViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Properties
    
    var foodId: String?
    
    var food: Food?
    
    @IBOutlet weak var foodMeasurePickerView: UIPickerView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var foodCaloriesLabel: UILabel!
    
    @IBOutlet weak var foodFatLabel: UILabel!
    
    @IBOutlet weak var foodCarbLabel: UILabel!
    
    @IBOutlet weak var foodProteinLabel: UILabel!
    
    var wheelArray: [[String]] = []
    
    var count: Int = 1
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Food Info"
        
        wheelArray = [Array(1...300).map{String($0)}]
        
        super.showLoading()
        
        FoodService().getFood(id: foodId!) { food in
            super.stopLoading()
            
            if food != nil {
                self.food = food
                self.configFoodInfo()
                
                // adding measure to wheel
                self.wheelArray.append([((food?.measure)?.components(separatedBy: "(")[0])!])
                self.foodMeasurePickerView.reloadAllComponents()
            } else {
                super.showAlert(title: "Error", text: "There is some error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configFoodInfo() {
        foodNameLabel.text = food?.name
        //foodCaloriesLabel.text = food?.nutrients.
        
        for nutrient in (food?.nutrients)! {
            
            switch (nutrient.name)! {
            case "Protein":
                foodProteinLabel.text = "\(Double(nutrient.value!)! * Double(count))"
            case "Total lipid (fat)":
                foodFatLabel.text = "\(Double(nutrient.value!)! * Double(count))"
            case "Carbohydrate, by difference":
                foodCarbLabel.text = "\(Double(nutrient.value!)! * Double(count))"
            default:
                foodCaloriesLabel.text = "\(Int(nutrient.value!)! * count))"
            }
        }
    }
    
    // MARK: UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return wheelArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return wheelArray[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }

        label.textColor = pinkColor!
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightThin)
        label.text = wheelArray[component][row]
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.count = Int(wheelArray[0][row])!
        self.configFoodInfo()
    }
    
    
    // MARK: IBActions
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        print("button tapped")
    }
}
