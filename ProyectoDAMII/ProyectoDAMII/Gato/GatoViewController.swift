//
//  GatoViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 4/05/24.
//

import UIKit

struct Gato {
    var nombre: String
    var precio: Double
    var stock: Int16
    var descripcion: String
}


class GatoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var gatoTableView: UITableView!
    
    
    var gatoList: [Gato] = []
    var gatoEntidadList: [GatoEntity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gatoTableView.dataSource = self
        gatoTableView.delegate = self
        listarGatos()
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
            self.registrarGato(nombre: nombre, precio: precio, stock: stock, descripcion: descripcion)
        })
        
        alerta.addAction(action)
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
    
    // funcion buscar
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gato = gatoEntidadList[indexPath.row]
        print("Nombre:",gato.nombre ?? "")
        print("Precio:",gato.precio)
        print("Stock:",gato.stock)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GatoDetalleViewController") as! GatoDetalleViewController
        vc.nombre = gato.nombre ?? ""
        vc.precio = String(gato.precio)
        vc.stock = String(gato.stock)
        vc.descripcion = gato.descripcion ?? ""
        vc.Gato = gato
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //ELIMINAR XD
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, completionHandler) in
            // Que item vamos a remover?
            let itemToRemove = self.gatoEntidadList[indexPath.row]
            // Eliminar el item
            managedContext.delete(itemToRemove)
            // Guardar los datos
            do {
                try managedContext.save()
            }
            catch {
                
            }
            // Recargar la tabla
            self.listarGatos()
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
        var gatoObj = self.gatoEntidadList[indexPath.row]
        let precio : String = String(gatoObj.precio)
        let stock : String = String(gatoObj.stock)
        
        
        //Accion actualizar
        let action = UIContextualAction(style: .normal, title: "Actualizar") { (action, view, completionHandler) in
            
            //Crear contenedor
            let alerta = UIAlertController(title: "Actualizar gato", message: "Complete los campos", preferredStyle: .alert)
            
            alerta.addTextField{
                alertTextField in alertTextField.text = gatoObj.nombre
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
                alertTextField in alertTextField.text = gatoObj.descripcion
                descTextField = alertTextField
            }
            
            let action = UIAlertAction(title: "Actualizar", style: .default, handler: { action in
                gatoObj.nombre = nombreTextField.text
                gatoObj.precio = Double(precioTextField.text!) ?? 0
                gatoObj.stock = Int16(stockTextField.text!) ?? 0
                gatoObj.descripcion = descTextField.text
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("No fue posible guardar los datos \(error), \(error.userInfo)")
                }
                
                // Actualizamos la lista de juguetes después de la modificación
                self.listarGatos()
            })
            
            alerta.addAction(action)
            alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func registrarGato(nombre: String?, precio: String?, stock: String?, descripcion: String?){
        if let name = nombre, let price = precio, let stock = stock, let description = descripcion{
            /*let juguete = Juguete(nombre: name, precio: Double(price) ?? 0, stock: Int16(stock) ?? 0)
             juguetesList.append(juguete)
             juguetesTableView.reloadData()*/
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entidad = GatoEntity(context: managedContext)
            entidad.nombre = name
            entidad.precio = Double(price) ?? 0
            entidad.stock = Int16(stock) ?? 0
            entidad.descripcion = description
            do{
                try managedContext.save()
                gatoEntidadList.append(entidad)
            }
            catch let error as NSError{
                print("No fue posible guardar los datos \(error), \(error.userInfo)")
            }
            gatoTableView.reloadData()
        }
    }
    
    func listarGatos(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            let results = try
            managedContext.fetch(GatoEntity.fetchRequest())
            gatoEntidadList = results as! [GatoEntity]
        }
        catch let error as NSError{
            print("No fue posible guardar los datos \(error), \(error.userInfo)")
        }
        gatoTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gatoEntidadList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gatoCell", for: indexPath) as! GatoTableViewCell
        
        // let juguete = juguetesList[indexPath.row]
        let gato = gatoEntidadList[indexPath.row]
        
        cell.nombreLabel.text = gato.nombre
        cell.precioLabel.text = String(gato.precio)
        cell.stockLabel.text = String(gato.stock)
        
        return cell
    }
}
