//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 24/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit
import CoreData

class MoviesTableViewController: UITableViewController {

    // MARK: - Properties
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Sem filmes cadastrados"
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 16.0)
        return label
    }()
    lazy var fetchedResultsController: NSFetchedResultsController<Movie> = {
        
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MovieViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
        vc.movie = fetchedResultsController.object(at: indexPath)
    }

    // MARK: - Methods
    private func loadMovies() {
        try? fetchedResultsController.performFetch()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count > 0 ? nil : label
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = fetchedResultsController.object(at: indexPath)
        cell.configure(with: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = fetchedResultsController.object(at: indexPath)
            context.delete(movie)
            try? context.save()
        }
    }

    }

extension MoviesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
