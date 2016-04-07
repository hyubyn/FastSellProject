//
//  AddATMViewController.swift
//  FastSell
//
//  Created by HYUBYN on 4/6/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//

import UIKit
import CoreLocation

class AddATMViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var lngTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        AppUtils.addRadius(addButton)
        addressTextView.layer.borderColor = UIColor.darkGrayColor().CGColor
        addressTextView.layer.borderWidth = 0.5
        AppUtils.addRadius(addressTextView)
        LocationManager.sharedInstance.delegate = self
        nameTextField.delegate = self
        addressTextView.delegate = self
    }
    
    private func checkInformationFilled() -> Bool {
        return !nameTextField.text!.isEmpty && !addressTextView.text.isEmpty && !latTextField.text!.isEmpty && !lngTextField.text!.isEmpty
    }
}

//MARK: LocationManagerDelegate
extension AddATMViewController: LocationManagerDelegate {
    func didUpdateToLocation(location: CLLocation) {
        latTextField.text = "\(location.coordinate.latitude)"
        lngTextField.text = "\(location.coordinate.longitude)"
    }
}

//MARK: User Interactions
extension AddATMViewController {
    @IBAction func addButtonTapped(sender: AnyObject) {
        if checkInformationFilled() {
            let newATM = ATM(value: [nameTextField.text!.uppercaseString, addressTextView.text, latTextField.text!, lngTextField.text!])
            newATM.add()
            AppUtils.showAlert("Information", message: "New ATM inserted successfully!", viewController: self)
        } else {
            AppUtils.showAlert("Lack of Information", message: "Please insert all of Information!", viewController: self)
        }
    }

}

//MARK UITextFieldDelegate
extension AddATMViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.endEditing(true)
        return true
    }
}
