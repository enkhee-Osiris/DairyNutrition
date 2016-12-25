//
//  ExerciseDetailsViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-25.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import AlecrimCoreData

class ExerciseDetailsViewController: MainViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Properties
    
    @IBOutlet weak var exerciseDurationPickerView: UIPickerView!
    
    @IBOutlet weak var burnedCaloriesLabel: UILabel!
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    var exerciseName: String?
    
    var exerciseValue: Double?
    
    var hours: Int = 0
    var minutes: Int = 1
    var duration: Int = 0
    
    var wheelArray: [[String]] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.exerciseNameLabel.text = exerciseName!
        
        wheelArray = [Array(0...5).map{String($0)}]
        wheelArray.append(["hours"])
        wheelArray.append(Array(1...60).map{String($0)})
        wheelArray.append(["minutes"])
        
        self.configExerciseInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if component == 0 {
            self.hours = Int(wheelArray[0][row])!
        } else if component == 2 {
            self.minutes = Int(wheelArray[2][row])!
        }
        self.configExerciseInfo()
    }
    
    
    func configExerciseInfo(){
        self.duration = (self.hours * 60) + self.minutes
        
        let weight = Shared.shared.currentUser.weight!
        let calories = Int(round(Double(self.duration) * self.exerciseValue! * weight))
        
        self.burnedCaloriesLabel.text = "\(calories)"
    }
    
    // MARK: - IBAction
    
    @IBAction func saveButtonTapeed(_ sender: Any) {
        let weight = Shared.shared.currentUser.weight!
        let calories = Int16(round(Double(self.duration) * self.exerciseValue! * weight))
        
        self.saveExercise(self.exerciseName!, calories)
        
        super.showAlert(title: "Food Added", text: "Exercise has been successfully added", handler: { (_) -> Void in
            super.presentVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "BaseViewController"))!)
        })
    }
}

extension ExerciseDetailsViewController {
    fileprivate func saveExercise(_ name: String, _ value: Int16){
        
        let identifier = UUID().uuidString
        
        persistentContainer.performBackgroundTask { backgroundContext in
            
            let exercise = backgroundContext.exercises.create()
            
            if exercise.isInserted {
                exercise.identifier = identifier
            }
            
            exercise.name = name
            exercise.value = value
            
            exercise.date = Shared.shared.selectedDate
            
            try! backgroundContext.save()
        }
    }
}
