//
//  SettingsViewController.swift
//  TemperatureConverter
//
//  Created by Trifonov Dmitry on 3/17/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var decimalPlacesLabel: UILabel!
    @IBOutlet weak var decimalPlacesStepper: UIStepper!
    var decimalPlaces: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        decimalPlacesStepper.value = decimalPlaces
        decimalPlacesLabel.text = String(format: "%.\(Int(decimalPlaces))f", decimalValue())
    }
    @IBAction func onPressedApplyButton(_ sender: Any) {
        //TODO
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onDecimalPlacesChanged(_ sender: Any) {
        decimalPlaces = decimalPlacesStepper.value
        decimalPlacesLabel.text = String(format: "%.\(Int(decimalPlaces))f", decimalValue())
    }
    
    func decimalValue() -> Double {
        return 1.0 / 3.0
    }
}
