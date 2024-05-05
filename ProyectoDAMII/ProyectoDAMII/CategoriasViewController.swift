//
//  CategoriasViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 4/05/24.
//

import UIKit

class CategoriasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func abrirCategorias(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JuguetesViewController") as! JuguetesViewController
        // Usando opcionales
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        let navController = UINavigationController(rootViewController: vc)
        //navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
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
