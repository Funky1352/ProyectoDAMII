//
//  JuguetesViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 28/04/24.
//

import UIKit
struct Juguete {
    var nombre: String
    var precio: Double
    var stock: Int16
    var descripcion: String
}

class JuguetesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var juguetesTableView: UITableView!
    var juguetesList: [Juguete] = []
    var jugueteEntidadList: [JugueteEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        juguetesTableView.dataSource = self
        juguetesTableView.delegate = self
        listarJuguetes()
        
        // juguetesList.append(Juguete(nombre: "Pelota ", precio: 20.5, stock: 32))
    }
    
    @IBAction func abrirAlertaRegistro(_ sender: Any) {
        
        var nombreTextField = UITextField()
        var precioTextField = UITextField()
        var stockTextField = UITextField()
        var descTextField = UITextField()
        
        let alerta = UIAlertController(title: "Registrar nuevo juguete", message: "Complete los campos", preferredStyle: .alert)
        
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
            self.registrarJuguete(nombre: nombre, precio: precio, stock: stock, descripcion: descripcion)
        })
        
        alerta.addAction(action)
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juguete = jugueteEntidadList[indexPath.row]
        print("Nombre:",juguete.nombre ?? "")
        print("Precio:",juguete.precio)
        print("Stock:",juguete.stock)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JugueteDetalleViewController") as! JugueteDetalleViewController
        vc.nombre = juguete.nombre ?? ""
        vc.precio = String(juguete.precio)
        vc.stock = String(juguete.stock)
        vc.descripcion = juguete.descripcion ?? ""
        vc.Juguete = juguete
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, completionHandler) in
            // Que item vamos a remover?
            let itemToRemove = self.jugueteEntidadList[indexPath.row]
            // Eliminar el item
            managedContext.delete(itemToRemove)
            // Guardar los datos
            do {
                try managedContext.save()
            }
            catch {
                
            }
            // Recargar la tabla
            self.listarJuguetes()
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
        var jugeteObj = self.jugueteEntidadList[indexPath.row]
        let precio : String = String(jugeteObj.precio)
        let stock : String = String(jugeteObj.stock)
        
        
        //Accion actualizar
        let action = UIContextualAction(style: .normal, title: "Actualizar") { (action, view, completionHandler) in
            
            //Crear contenedor
            let alerta = UIAlertController(title: "Actualizar juguete", message: "Complete los campos", preferredStyle: .alert)
            
            alerta.addTextField{
                alertTextField in alertTextField.text = jugeteObj.nombre
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
                alertTextField in alertTextField.text = jugeteObj.descripcion
                descTextField = alertTextField
            }
            
            let action = UIAlertAction(title: "Actualizar", style: .default, handler: { action in
                jugeteObj.nombre = nombreTextField.text
                jugeteObj.precio = Double(precioTextField.text!) ?? 0
                jugeteObj.stock = Int16(stockTextField.text!) ?? 0
                jugeteObj.descripcion = descTextField.text
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("No fue posible guardar los datos \(error), \(error.userInfo)")
                }
                
                // Actualizamos la lista de juguetes después de la modificación
                self.listarJuguetes()
            })
            
            alerta.addAction(action)
            alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
     let managedContext = appDelegate.persistentContainer.viewContext
     
     let itemToUpdate = self.contactosEntidadList[indexPath.row]
     
     var nombreTextField = UITextField()
     var numeroTextField = UITextField()
     // Crear la alerta para poder editar los datos
     let alerta = UIAlertController(title: "Actualizar Contacto", message: "Complete todos los datos", preferredStyle: .alert)
     alerta.addTextField {
     // Llamar a los datos para que se completen en el textfield y nos sirvan de guia al momento de actualizar
     alertTextField in alertTextField.text = itemToUpdate.nombre
     nombreTextField = alertTextField
     }
     alerta.addTextField {
     // Llamar a los datos para que se completen en el textfield y nos sirvan de guia al momento de actualizar
     alertTextField in alertTextField.text = itemToUpdate.numero
     numeroTextField = alertTextField
     }
     // Boton de accion para actualizar
     let action = UIAlertAction(title: "Actualizar", style: .default, handler: {
     action in
     // Cambiar los datos del contacto
     itemToUpdate.nombre = nombreTextField.text
     itemToUpdate.numero = numeroTextField.text
     // Guardar los datos
     do{
     try managedContext.save()
     }
     catch {
     
     }
     // Recargar la tabla
     self.listarContactos()
     })
     alerta.addAction(action)
     alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
     present(alerta, animated: true, completion: nil)
     }*/
    func registrarJuguete(nombre: String?, precio: String?, stock: String?, descripcion: String?){
        if let name = nombre, let price = precio, let stock = stock, let description = descripcion{
            /*let juguete = Juguete(nombre: name, precio: Double(price) ?? 0, stock: Int16(stock) ?? 0)
             juguetesList.append(juguete)
             juguetesTableView.reloadData()*/
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entidad = JugueteEntity(context: managedContext)
            entidad.nombre = name
            entidad.precio = Double(price) ?? 0
            entidad.stock = Int16(stock) ?? 0
            entidad.descripcion = description
            do{
                try managedContext.save()
                jugueteEntidadList.append(entidad)
            }
            catch let error as NSError{
                print("No fue posible guardar los datos \(error), \(error.userInfo)")
            }
            juguetesTableView.reloadData()
        }
    }
    
    func listarJuguetes(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            let results = try
            managedContext.fetch(JugueteEntity.fetchRequest())
            jugueteEntidadList = results as! [JugueteEntity]
        }
        catch let error as NSError{
            print("No fue posible guardar los datos \(error), \(error.userInfo)")
        }
        juguetesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return juguetesList.count
        return jugueteEntidadList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jugueteCell", for: indexPath) as! JugueteTableViewCell
        
        // let juguete = juguetesList[indexPath.row]
        let juguete = jugueteEntidadList[indexPath.row]
        
        cell.nombreLabel.text = juguete.nombre
        cell.precioLabel.text = String(juguete.precio)
        cell.stockLabel.text = String(juguete.stock)
        
        return cell
    }
}
