//
//  ViewController.swift
//  Conversion Calculator App
//
//  Created by Collin Turkelson on 2/4/20.
//  Copyright © 2020 Collin Turkelson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UnitsSelectionViewControllerDelegate {
    //Decides whether we are dealing with length or volume
    let modes: [String] = ["Length","Volume"]
    

    
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
                dest.currMode = modes[currentModeIndex%2]
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
    
    //calculates the opposing field when calculate is tapped
    @IBAction func calculateTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if(toTextField.text! == "" && fromTextField.text! != ""){
       
        }
        else if(fromTextField.text! == "" && toTextField.text! != ""){
            
        }
        else{
            print("go away")
        }
        
        
    }
    
    
}

