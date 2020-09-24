//
//  Movie.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 24/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import Foundation

struct Movie : Decodable {
    
    let title: String?
    let categories: String?
    let duration: String?
    let rating: Double?
    let summary: String?
    let image: String?
}
