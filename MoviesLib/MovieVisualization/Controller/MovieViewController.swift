//
//  MovieViewController.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 26/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit

final class MovieViewController: UIViewController {
    
    var movie: Movie!

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelTitle.text = movie.title
        imageViewPoster.image = movie.poster
        labelRating.text = movie.ratingFormatted
        labelDuration.text = movie.duration
        textViewSummary.text = movie.summary
        
        labelCategories.text = (movie.categories as? Set<Category>)?.compactMap({ $0.name }).sorted().joined(separator: " | ")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieFormViewController {
            vc.movie = movie
        }
    }
}
