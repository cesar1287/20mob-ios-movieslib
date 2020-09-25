//
//  Movie+RatingFormatted.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 24/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import Foundation

extension Movie {
    
    var ratingFormatted: String {
        "⭐️ \(rating ?? 0)/10"
    }
}
