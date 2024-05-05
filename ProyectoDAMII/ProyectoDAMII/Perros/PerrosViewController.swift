//
//  PerrosViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 4/05/24.
//

import UIKit
struct Perro {
    var nombre: String
    var precio: Double
    var stock: Int16
    var descripcion: String
}

class PerrosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var perrosTableView: UITableView!
    var perrosList: [Perro] = []
    var perroEntidadList: [PerroEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perrosTableView.dataSource = self
        perrosTableView.delegate = self
        listarPerros()
        // Do any additional setup after loading the view.
    }
    @IBAction func abrirAlertaRegistro(_ sender: Any) {
        
        var nombreTextField = UITextField()
        var precioTextField = UITextField()
        var stockTextField = UITextField()
        var descTextField = UITextField()
        
        let alerta = UIAlertController(title: "Registrar nuevo producto", message: "Complete los campos", preferredStyle: .alert)
        
        alerta.addTextField{
            alertTextField in alertTextField.placeholder = "Ingrese el nombre"
            nombreTextField = alertTextField
        }
        
        alerta.addTextField{
            alertTextField in alertTextField.placeholder = "Ingrese el precio"
            precioTextField = alertTextField
        }
        
        alerta.addTextField{
            alertTextField in alertTextField.placeholder = "Ingrese el stock"
            stockTextField = alertTextField
        }
        
        alerta.addTextField{
            alertTextField in alertTextField.placeholder = "Ingrese la descripcion"
            descTextField = alertTextField
        }
        
        let action = UIAlertAction(title: "Registrar", style: .default, handler: { action in
            let nombre = nombreTextField.text
            let precio = precioTextField.text
            let stock = stockTextField.text
            let descripcion = descTextField.text
            self.registrarPerro(nombre: nombre, precio: precio, stock: stock, descripcion: descripcion)
        })
        
        alerta.addAction(action)
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let perro = perroEntidadList[indexPath.row]
        print("Nombre:",perro.nombre ?? "")
        print("Precio:",perro.precio)
        print("Stock:",perro.stock)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PerroDetalleViewController") as! PerroDetalleViewController
        vc.nombre = perro.nombre ?? ""
        vc.precio = String(perro.precio)
        vc.stock = String(perro.stock)
        vc.descripcion = perro.descripcion ?? ""
        vc.Perro = perro
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, completionHandler) in
            // Que item vamos a remover?
            let itemToRemove = self.perroEntidadList[indexPath.row]
            // Eliminar el item
            managedContext.delete(itemToRemove)
            // Guardar los datos
            do {
                try managedContext.save()
            }
            catch {
                
            }
            // Recargar la tabla
            self.listarPerros()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // campos del alert
        var nombreTextField = UITextField()
        var precioTextField = UITextField()
        var stockTextField = UITextField()
        var descTextField = UITextField()
        
        // Objeto a recibir
        var perroObj = self.perroEntidadList[indexPath.row]
        let precio : String = String(perroObj.precio)
        let stock : String = String(perroObj.stock)
        
        
        //Accion actualizar
        let action = UIContextualAction(style: .normal, title: "Actualizar") { (action, view, completionHandler) in
            
            //Crear contenedor
            let alerta = UIAlertController(title: "Actualizar perro", message: "Complete los campos", preferredStyle: .alert)
            
            alerta.addTextField{
                alertTextField in alertTextField.text = perroObj.nombre
                nombreTextField = alertTextField
            }
            
            alerta.addTextField{
                
                alertTextField in alertTextField.text = precio
                precioTextField = alertTextField
            }
            
            alerta.addTextField{
                alertTextField in alertTextField.text = stock
                stockTextField = alertTextField
            }
            
            alerta.addTextField{
                alertTextField in alertTextField.text = perroObj.descripcion
                descTextField = alertTextField
            }
            
            let action = UIAlertAction(title: "Actualizar", style: .default, handler: { action in
                perroObj.nombre = nombreTextField.text
                perroObj.precio = Double(precioTextField.text!) ?? 0
                perroObj.stock = Int16(stockTextField.text!) ?? 0
                perroObj.descripcion = descTextField.text
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("No fue posible guardar los datos \(error), \(error.userInfo)")
                }
                
                // Actualizamos la lista de juguetes después de la modificación
                self.listarPerros()
            })
            
            alerta.addAction(action)
            alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func registrarPerro(nombre: String?, precio: String?, stock: String?, descripcion: String?){
        if let name = nombre, let price = precio, let stock = stock, let description = descripcion{
            /*let juguete = Juguete(nombre: name, precio: Double(price) ?? 0, stock: Int16(stock) ?? 0)
             juguetesList.append(juguete)
             juguetesTableView.reloadData()*/
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entidad = PerroEntity(context: managedContext)
            entidad.nombre = name
            entidad.precio = Double(price) ?? 0
            entidad.stock = Int16(stock) ?? 0
            entidad.descripcion = description
            do{
                try managedContext.save()
                perroEntidadList.append(entidad)
            }
            catch let error as NSError{
                print("No fue posible guardar los datos \(error), \(error.userInfo)")
            }
            perrosTableView.reloadData()
        }
    }
    
    
    func listarPerros(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            let results = try
            managedContext.fetch(PerroEntity.fetchRequest())
            perroEntidadList = results as! [PerroEntity]
        }
        catch let error as NSError{
            print("No fue posible guardar los datos \(error), \(error.userInfo)")
        }
        perrosTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return perroEntidadList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "perroCell", for: indexPath) as! PerroTableViewCell
        
        // let juguete = juguetesList[indexPath.row]
        let perro = perroEntidadList[indexPath.row]
        
        cell.nombreLabel.text = perro.nombre
        cell.precioLabel.text = String(perro.precio)
        cell.stockLabel.text = String(perro.stock)
        
        return cell
    }
    

}
