//
//  ViewController.swift
//  PokemInf
//
//  Created by Victor Tejeda on 22/11/22.
//

import UIKit

class ListaPokemonViewController: UIViewController {
    
    // MARK: - IBOutletes
    
    @IBOutlet weak var tablaPokemon: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    // MARK: - Variables
    var pokemonmanager = PokemonManager()
    
    var pokemons: [Pokemon] = []
    
    var cualPokemon: Pokemon?
    
    var pokemonFiltrados: [Pokemon] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar la nueva celdapokemon que cree con animacion.
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        pokemonmanager.delegado = self
        
        searchBarPokemon.delegate = self
        
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        //Ejecutar el metodo para buscar la lista de pokemon en la api
        pokemonmanager.verPokemon()
        
        
    }
}

// MARK: - SearchBar
extension ListaPokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        pokemonFiltrados = []
        
        if searchText == "" {
            pokemonFiltrados = pokemons
            } else {
                for poke in pokemons {
                    if poke.name.lowercased().contains(searchText.lowercased()) {
                        pokemonFiltrados.append(poke)
                        
                    }
                }
            }
        self.tablaPokemon.reloadData()
    }
}

// MARK: Delegado Pokemon
extension ListaPokemonViewController: pokemonManagerDelegado {
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        DispatchQueue.main.async {
            self.pokemonFiltrados = lista
            self.tablaPokemon.reloadData()
        }
    }
    
    
}

// MARK: Tabla

extension ListaPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        celda.nombrePokemon.text = pokemonFiltrados[indexPath.row].name
        celda.ataquePokemon.text = "Ataque: \(pokemonFiltrados[indexPath.row].attack)"
        celda.defensaPokemon.text = "Defensa: \(pokemonFiltrados[indexPath.row].defense)"
        
        //Celda imagen desde URL
        if let urlString = pokemonFiltrados[indexPath.row].imageUrl as? String {
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else { return }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagenPokemon.image = image
                    }
                }
            }
        }
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cualPokemon = pokemonFiltrados[indexPath.row]
        
        performSegue(withIdentifier: "verPokemon", sender: self)
        
        //Deselecionar
        tablaPokemon.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon" {
            let verPokemon = segue.destination as! DetallePokemonViewController
            verPokemon.pokemonMostrar = cualPokemon
        }
    }
}
