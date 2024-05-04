//
//  JugueteDetalleViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 29/04/24.
//

import UIKit

class JugueteDetalleViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var precioTextField: UITextField!
    @IBOutlet weak var stocktextField: UITextField!
    @IBOutlet weak var descripcionTextView: UITextView!
    
    var nombre: String = ""
    var precio: String = ""
    var stock: String = ""
    var descripcion: String = ""
    var Juguete: JugueteEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreTextField.text = nombre
        precioTextField.text = precio
        stocktextField.text = stock
        descripcionTextView.text = descripcion
    }
}
