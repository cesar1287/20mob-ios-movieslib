//
//  ViewController.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 22/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    var movies: [Movie] = []
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }

    //MARK: - Methods
    private func loadMovies() {
        guard let jsonURL = Bundle.main.url(forResource: "movies", withExtension: "json") else {return}
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            let jsonDecoder = JSONDecoder()
            
            
            movies = try jsonDecoder.decode([Movie].self, from: jsonData)
            
            movies.forEach { print($0.title) }
        } catch {
            print(error)
        }
    }
}

