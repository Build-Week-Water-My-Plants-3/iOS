//
//  NewUserRegisterViewController.swift
//  WaterMyPlants
//
//  Created by Craig Swanson on 2/26/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class NewUserRegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    var userController = UserController()
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = CGColor(srgbRed: 0.400, green: 0.659, blue: 0.651, alpha: 1.0)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Action Handlers
    @IBAction func buttonTapped(_ sender: UIButton) {
    
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let phoneNumber = phoneNumberTextField.text,
            !phoneNumber.isEmpty {
            
            currentUser = User(password: password, phoneNumber: phoneNumber, username: username)
            let user = UserRepresentation(password: password,
                                          phoneNumber: phoneNumber,
                                          username: username)
            
            userController.signUp(with: user) { error in
                
                if let error = error {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(
                            title: "Sign Up Successfull",
                            message: "Now please log in.",
                            preferredStyle: .alert)
                        let alertAction = UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default,
                            handler: { action -> Void in
                                self.performSegue(withIdentifier: "SignInSegue", sender: self)
                        })
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true)
                        self.usernameTextField.text = ""
                        self.passwordTextField.text = ""
                        self.phoneNumberTextField.text = ""
                    }
                    print("Error did not occur during sign up: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.usernameTextField.text = ""
                        self.passwordTextField.text = ""
                        self.phoneNumberTextField.text = ""
                        
                        let alertController = UIAlertController(
                            title: "Sign Up not Successfull",
                            message: "Username already exists, please try again.",
                            preferredStyle: .alert)
                        let alertAction = UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default,
                            handler: nil)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true)
                        
                    } 
                }
            }
            
        }
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SignInSegue" {
                if let signInVC = segue.destination as? UserSignInViewController {
                    signInVC.currentUser = currentUser
                }
            }
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
