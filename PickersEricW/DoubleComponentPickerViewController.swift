//
//  DoubleComponentPickerViewController.swift
//  PickersEricW
//
//  Created by Eric J Witowski on 2/19/18.
//  Copyright © 2018 Eric J Witowski. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    
    @IBOutlet var doublePicker: UIView!
    
    private let fillingComponent = 0
    private let breadComponent = 1
    private let fillingTypes = [
        "Ham", "Turkey", "Peanut Butter", "Tuna Salad",
        "Chicken Salad", "Roast Beef", "Vegemite"]
    private let breadTypes = [
        "white", "whole wheat", "rye", "sourdough",
        "Seven grain"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onButtonPressed(_ sender: Any) {
        let fillingRow = doublePicker.selectedRow(inComponent: fillingComponent)
        let breadRow = doublePicker.selectedRow(inComponent: breadComponent)

let filling = fillingTypes[fillingRow]
let bread = breadTypes[breadRow]
let message = "Your \(filling) on \(bread) bread will be right up."
let alert = UIAlertController(
    title: "Thank you for your order", message: message, preferredStyle: .Alert)
let action = UIAlertAction(
    title: "Great", style: .default, handler: nil)
alert.addAction(action)
present(alert, animated: true, completion: nil)
}
// MARK: -
// MARK: Picker Data Source Methods
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
}
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == breadComponent {
        return breadTypes.count
    } else { return fillingTypes.count }
}
// MARK: -
// MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if component == breadComponent {
        return breadTypes[row]
    } else { return fillingTypes[row] }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */}

