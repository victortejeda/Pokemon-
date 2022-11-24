//
//  DetallePokemonViewController.swift
//  PokemInf
//
//  Created by Victor Tejeda on 23/11/22.
//

import UIKit

class DetallePokemonViewController: UIViewController {
    
    // MARK: - Variables
    var pokemonMostrar: Pokemon?
    
    // MARK: - IBOutkets vinculacion.
    
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var descripcionPokemon: UITextView!
    @IBOutlet weak var tipoPokemon: UILabel!
    @IBOutlet weak var atacaPokemon: UILabel!
    @IBOutlet weak var defensaPokemon: UILabel!
    @IBOutlet weak var pesoPokemon: UILabel!
    @IBOutlet weak var alturaPokemon: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //extracion forzada con !
        //extracion forma opcional con ?

        tipoPokemon.text = "tipo : \(pokemonMostrar?.type ?? "")"
        atacaPokemon.text = "Ataque : \(pokemonMostrar!.attack)"
        defensaPokemon.text = "Defensa : \(pokemonMostrar!.defense)"
        descripcionPokemon.text = pokemonMostrar?.description ?? ""
        imagenPokemon.loadFrom(URLAddres: pokemonMostrar?.imageUrl ?? "")
        alturaPokemon.text = "Altura : \(pokemonMostrar!.height)"
        pesoPokemon.text = "Peso : \(pokemonMostrar!.weight)"
    }
}

//MOstrar una imagen a partir de una url

extension UIImageView {
    func loadFrom(URLAddres: String) {
        guard let url = URL(string: URLAddres) else {
            return
            
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
