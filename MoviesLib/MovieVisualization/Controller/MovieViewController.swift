//
//  ViewController.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 22/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit

final class MovieViewController: UIViewController {
    
    var movie: Movie!

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    // MARK: - Properties
    var movies: [Movie] = []
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        labelTitle.text = movie.title
        labelRating.text = movie.ratingFormatted
//        labelCategories.text = movie.categories
        textViewSummary.text = movie.summary
    }

    //MARK: - Methods
}

