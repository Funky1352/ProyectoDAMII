//
//  UtilityFunctions.swift
//  ProyectoDAMII
//
//  Created by DAMII on 9/05/24.
//

import UIKit

class UtilityFunction: NSObject {
    
    func simpleAlert(vc: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
}
