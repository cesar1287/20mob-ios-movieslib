//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 24/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    // MARK: - Properties
    var movies: [Movie] = []
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextScreen = segue.destination as? ViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
        nextScreen.movie = movies[indexPath.row]
    }

    //MARK: - Methods
    private func loadMovies() {
        guard let jsonURL = Bundle.main.url(forResource: "movies", withExtension: "json") else {return}
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            let jsonDecoder = JSONDecoder()
            
            movies = try jsonDecoder.decode([Movie].self, from: jsonData)
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
}
