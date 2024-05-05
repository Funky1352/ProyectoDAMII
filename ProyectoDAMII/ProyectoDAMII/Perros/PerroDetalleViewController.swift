//
//  PerroDetalleViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 4/05/24.
//

import UIKit

class PerroDetalleViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var precioTextField: UITextField!
    @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var descTextField: UITextView!
    
    var nombre: String = ""
    var precio: String = ""
    var stock: String = ""
    var descripcion: String = ""
    var Perro: PerroEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreTextField.text = nombre
        precioTextField.text = precio
        stockTextField.text = stock
        descTextField.text = descripcion

        // Do any additional setup after loading the view.
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
