//
//  ViewController.swift
//  Conversion Calculator App
//
//  Created by Collin Turkelson on 2/4/20.
//  Copyright © 2020 Collin Turkelson. All rights reserved.
//

import UIKit
protocol modeDelegate {
    func curMode(mode: String)
}
class ViewController: UIViewController, UnitsSelectionViewControllerDelegate {
    //Decides whether we are dealing with length or volume
    let modes: [String] = ["Length","Volume"]
    
     var delegate: modeDelegate?
    
    //Increments the index, and takes the modularity
    var currentModeIndex: Int = 0
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //sets up tap gesture to dismiss the keyboard
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //assigns tap guesture to the feild
        self.view.addGestureRecognizer(touch)
    }
    
    //protocol function that accepts unit change
    func indicateSelection(fromUnits: String, toUnits: String) {
        toLabel.text = toUnits
        fromLabel.text = fromUnits
        fromTextField.placeholder = "Enter \(modes[currentModeIndex%2]) in \(fromLabel.text!)"
        toTextField.placeholder = "Enter \(modes[currentModeIndex%2]) in \(toLabel.text!)"
    }

    //Prepares the segue to accept unit change
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseUnits" {
            if let dest = segue.destination as? UnitsViewController {
                dest.delegate = self
            }
        }
    }
    //dismisses the keyboard when activated
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //clears the to field when from field tapped
    @IBAction func fromFieldTapped(_ sender: Any) {
        toTextField.text = ""
    }

    //clears the from field when to field tapped
    @IBAction func toFieldTapped(_ sender: UITextField) {
        fromTextField.text = ""
    }
    @IBAction func clearButton(_ sender: UIButton) {
        toTextField.text = ""
        fromTextField.text = ""
    }
    
    //changes the type of units when mode is tapped
    @IBAction func ModeTapped(_ sender: UIButton) {
        currentModeIndex += 1
        if(modes[currentModeIndex%2] == "Length"){
            fromLabel.text = "Yards"
            toLabel.text = "Meters"
        }
        else {
            fromLabel.text = "Liters"
            toLabel.text = "Quarts"
        }
        fromTextField.placeholder = "Enter \(modes[currentModeIndex%2]) in \(fromLabel.text!)"
        toTextField.placeholder = "Enter \(modes[currentModeIndex%2]) in \(toLabel.text!)"
    }
    
    @IBAction func Settings(_ sender: UIButton) {
        if let d = self.delegate {
            d.curMode(mode: modes[currentModeIndex%2])
        }
    }
    //calculates the opposing field when calculate is tapped
    @IBAction func calculateTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if(toTextField.text! == "" && fromTextField.text! != ""){
            let yard = Double(fromTextField.text!)
            let newNum = Double(yard! * 0.9144)
            toTextField.text = String(newNum)
        }
        else if(fromTextField.text! == "" && toTextField.text! != ""){
            let meter = Double(toTextField.text!)
            let newNum = Double(meter! / 0.9144)
            fromTextField.text = String(newNum)
        }
        else{
            print("go away")
        }
        
        
    }
    
    
}

