//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by Trifonov Dmitry on 3/16/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultSegmentControl: UISegmentedControl!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var initialSigmentControl: UISegmentedControl!
    @IBOutlet weak var settingsButtonItem: UIBarButtonItem!
    private var lastCorrectString: String = ""
    private var decimalPlaces = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowed = "1234567890-"
        let allowedSet = CharacterSet(charactersIn: allowed)
        let typedSet = CharacterSet(charactersIn: string)

        return allowedSet.isSuperset(of: typedSet)
    }
    
    @IBAction func onPressedSettingsButton(_ sender: Any) {
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        settingsViewController.decimalPlaces = self.decimalPlaces
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @IBAction func onEditTextFiledChanged(_ sender: Any) {
        changeTemperatureValue()
    }
    
    @IBAction func onResultViewControllerChanged(_ sender: Any) {
        changeTemperatureValue()
    }
    
    @IBAction func onInitialViewControllerChanged(_ sender: Any) {
        changeTemperatureValue()
    }
    
    @IBAction func onTextFieldTouchDown(_ sender: Any) {
        editTextField.text = ""
    }
    
    func changeTemperatureValue(){
        
        guard !editTextField.text!.isEmpty else{
            resultLabel.text = ""
            return
        }
    
        if (editTextField.text!.first == "0" && editTextField.text!.count > 1) {
            editTextField.text!.removeFirst()
        }
        
        if(editTextField.text!.first == "-" && editTextField.text!.count > 1){
            if(editTextField.text![editTextField.text!.index(editTextField.text!.startIndex, offsetBy: 1)] == "0"){
                editTextField.text!.remove(at: editTextField.text!.index(editTextField.text!.startIndex, offsetBy: 1))
            }
        }
    
        guard let value = Double(editTextField.text!) else {
             if (editTextField.text?.first == "-" && editTextField.text!.count == 1) {
                 lastCorrectString = editTextField.text!
                 resultLabel.text = ""
             } else {
                onlyTextWarning(controller: self, message: "Incorrect value", seconds: 0.2)
                editTextField.text = lastCorrectString
             }
            return
        }
        
        let idx = initialSigmentControl.selectedSegmentIndex
        
        var temp: Temparature
        
        if (idx == 0) {
            temp = Temparature.celcius(value)
        } else if (idx == 1) {
            temp = Temparature.farenheit(value)
        } else {
            temp = Temparature.kelvin(value)
        }
        
        let temperature = resultSegmentControl.titleForSegment(at: resultSegmentControl.selectedSegmentIndex)
        let result: Double? = convertTemperature(from: temp, targetTemperature: temperature ?? "")
        
        resultLabel.text = String(format: "%.\(Int(decimalPlaces))f", result!)
        lastCorrectString = editTextField.text ?? ""
    }
    
    func onlyTextWarning(controller: UIViewController,
                           message: String,
                           seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.1
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
