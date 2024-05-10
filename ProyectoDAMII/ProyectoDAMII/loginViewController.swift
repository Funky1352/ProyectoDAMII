//
//  loginViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 13/04/24.
//

import UIKit

class loginViewController: UIViewController {
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var claveTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ingresarButton(_ sender: Any) {
        if let email = usuarioTextField.text, let password = claveTextField.text {
            if email == "" && password == "" {
                UtilityFunction().simpleAlert(vc: self, title: "Alert!", message: "Complete los campos")
            } else {
                if !email.isValidEmail(email: email){
                    UtilityFunction().simpleAlert(vc: self, title: "Alert!", message: "Ingrese usuario valido")
                } else if !password.isValidPassword(password: password){
                    UtilityFunction().simpleAlert(vc: self, title: "Alert!", message: "Ingrese clave valida")
                } else {
                    // Navigation
                    /*
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "AccionesViewController") as! AccionesViewController
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "AccionesViewController") as! AccionesViewController
                     */
                }
            }
        }
    }
    
}

extension String{
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    // length 6 to 16
    // special character
    
    func isValidPassword(password: String) -> Bool{
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
}
