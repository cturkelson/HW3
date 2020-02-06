//
//  UnitsViewController.swift
//  Conversion Calculator App
//
//  Created by Collin Turkelson on 2/4/20.
//  Copyright © 2020 Collin Turkelson. All rights reserved.
//

import UIKit
protocol UnitsSelectionViewControllerDelegate {
    func indicateSelection(fromUnits: String, toUnits: String)
}

class UnitsViewController: UIViewController {

    //From Label that will change from the picker
    @IBOutlet weak var fromUnits: UILabel!
    
    //to label that will change form the picker
    @IBOutlet weak var toUnits: UILabel!
    
    var currMode: String = ""
   
    //UI picker to change the label vaules
    @IBOutlet weak var picker: UIPickerView!

    
    
    
    //data for Length conversions
    var lengthData: [String] = [String]()
    
    //data for Volume conversions
    var volumeData: [String] = [String]()
    
    //fromSelection that will send data to main viewcontroller
    var fromSelection: String = ""
    
    //toSelection that will send data to main viewcontroller
    var toSelection: String = ""
    
    //delegate that helps transfer information
    var delegate: UnitsSelectionViewControllerDelegate?
    
    //decides which label changes
    var labelChoose: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(currMode == "Volume") {
            fromSelection = "Liters"
            toSelection = "Quarts"
        }
        else {
            fromSelection = "Yards"
            toSelection = "Meters"
        }
        fromUnits.text = fromSelection
        toUnits.text = toSelection
        
        //sets up the array for the UIPicker
        self.lengthData = ["Yards", "Meters", "Miles"]
        
        self.volumeData = ["Liters", "Quarts", "Gallons"]
        
        
        //initializing delegate
        self.picker.delegate = self
        
        //initializing dataSource
        self.picker.dataSource = self
        
        //sets up from label tap, sets choose label to "from"
        self.setFromLabelTap()
        
        //sets up to label tap, sets choose label to "to"
        self.setToLabelTap()

        //initializes uiTapgeustre
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
       
        //assigns tap gesture to dismiss uiPicker
        self.view.addGestureRecognizer(touch)
    }
 
        
    //function to dismiss uiPicker
    @objc func dismissKeyboard() {
        picker.isHidden = true
    }
   
    //action to close the current viewController
    func closeView() {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    //action for the cancel button
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        closeView()
    }
    
    //action that will send the information to the main view controller, and close current viewController
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let d = self.delegate {
            d.indicateSelection(fromUnits: fromUnits.text!, toUnits: toUnits.text!)
        }
        closeView()
    }
    
    //UITapGesture for the to label
   @objc func tapTo(_: UITapGestureRecognizer) {
        picker.isHidden = false
        labelChoose = "To"
    }
    
    //UITapGesture for the from label
   @objc func tapFrom(_: UITapGestureRecognizer) {
        picker.isHidden = false
        labelChoose = "From"
    }

    //setting up UITapGesture for from label
    func setFromLabelTap(){
        let labelFromTap = UITapGestureRecognizer(target: self, action: #selector(self.tapFrom(_:)))
                  self.fromUnits.isUserInteractionEnabled = true
                  self.fromUnits.addGestureRecognizer(labelFromTap)
       }
    
    //setting up UITapGesture for to label
    func setToLabelTap(){
        labelChoose = "To"
        let labelToTap = UITapGestureRecognizer(target: self, action: #selector(self.tapTo(_:)))
               self.toUnits.isUserInteractionEnabled = true
               self.toUnits.addGestureRecognizer(labelToTap)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension for dataSource and delegate
extension UnitsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(currMode == "Length") {
            return lengthData.count
        }
        else {
            return volumeData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(currMode == "Length") {
              return self.lengthData[row]
        }
        else {
              return self.volumeData[row]
        }
      
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(currMode == "Length") {
            if(labelChoose == "From") {
                self.fromSelection = self.lengthData[row]
                fromUnits.text = self.fromSelection
        }
            else {
                self.toSelection = self.lengthData[row]
                toUnits.text = self.toSelection
        }
        }
        else {
            if(labelChoose == "From") {
                           self.fromSelection = self.volumeData[row]
                           fromUnits.text = self.fromSelection
                   }
                       else {
                           self.toSelection = self.volumeData[row]
                           toUnits.text = self.toSelection
        }
    }
}

}
