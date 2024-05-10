///
//  NoticiasViewController.swift
//  ProyectoDAMII
//
//  Created by DAMII on 9/05/24.
//

import UIKit
import SafariServices

struct NoticiasModelo: Codable {
    let articles: [Noticia]
}

struct Noticia: Codable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}



class NoticiasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celdaNoticia", for: indexPath) as! CeldaNoticiasTableViewCell
        celda.titulolabel.text = articulosNoticias[indexPath.row].title
        celda.descripcionLabel.text = articulosNoticias[indexPath.row].description
        
        /*if let url = URL(string: articulosNoticias[indexPath.row].urlToImage ?? ""){
            if let imagenData = try? Data(contentsOf: url) {
                celda.imagenNoticias.image = UIImage(data: imagenData)
            }
        }*/
        return celda
    }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablaNoticias.deselectRow(at: indexPath, animated: true)
        
        guard let urlMostrar = URL(string: articulosNoticias[indexPath.row].url ?? "") else { return }
        let VCSS = SFSafariViewController(url: urlMostrar)
        present(VCSS, animated: true)
    }
    
    var articulosNoticias : [Noticia] = []

    @IBOutlet weak var tablaNoticias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*tablaNoticias.register(UINib(nibName: "CeldaNoticiasTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaNoticia")*/
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        buscarNoticias()

        // Do any additional setup after loading the view.
    }
    
    func buscarNoticias() {
        let urlString =
            "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let decodificador = JSONDecoder()
                
                if let datosDecodificados = try?
                    decodificador.decode(NoticiasModelo.self, from: data) {
                    print("datosDecodificados: \(datosDecodificados.articles.count)")
                    articulosNoticias = datosDecodificados.articles
                    
                    tablaNoticias.reloadData()
                }
            }
        }
    }
    

}

