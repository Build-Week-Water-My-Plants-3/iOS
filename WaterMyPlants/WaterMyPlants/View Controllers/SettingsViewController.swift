//
//  SettingsViewController.swift
//  WaterMyPlants
//
//  Created by denis cedeno on 3/4/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPhoneNumberTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var userController = UserController()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = CGColor(srgbRed: 0.15, green: 0.30, blue: 0.75, alpha: 1.0)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let username = usernameTextField.text,
            !username.isEmpty,
            var newPassword = newPasswordTextField.text,
            var newPhoneNumber = newPhoneNumberTextField.text {
            
            if newPassword.isEmpty {
                newPassword = passwordTextField.text!
            }
            if newPhoneNumber.isEmpty {
                newPhoneNumber = phoneNumberTextField.text!
            }
            
            let user = UserRepresentation(password: newPassword,
                                          phoneNumber: newPhoneNumber,
                                          username: username)
            
            userController.updateUser(with: user) { error in
                if let error = error {
                    print("error fetching data: \(error)")
                    return
                }
                
                
                DispatchQueue.main.async {
                    
                    let alertController = UIAlertController(
                        title: "Update Successfull",
                        message: "Password or Phone Number Updated",
                        preferredStyle: .alert)
                    let alertAction = UIAlertAction(
                        title: "OK",
                        style: UIAlertAction.Style.default,
                        handler: {action in self.dismiss(animated: true, completion: nil)})
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
            }
            
        }
    }
    
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let user = user else { return }
        
        usernameTextField.text = user.username
        passwordTextField.text = user.password
        phoneNumberTextField.text = user.phoneNumber
        
        let phoneNumber = ""
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty {
            let user = UserRepresentation(password: password,
                                          phoneNumber: phoneNumber,
                                          username: username)
            
            userController.getUserPhoneNumber(with: user) { error in
                if let error = error {
                    print("error fetching phone number data: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.phoneNumberTextField.text = self.userController.phoneNumber
                }
            }
            
        }
    }
    
}
