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
        let usuario = usuarioTextField.text
        let clave = claveTextField.text
        
        if let user = usuario, let pass = clave {
            print("Usuario:",user)
            print("Clave:",pass)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AccionesViewController") as! AccionesViewController
        // Usando opcionales
        // self.present(vc, animated: true, completion: nil)
        // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
