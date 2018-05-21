//
//  movieDataModelItem.swift
//  MovieFinder-Swift
//
//  Created by sarath on 18/05/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import Foundation

struct movie: Decodable {
    
    let movie_name:String?
    let movie_year:String?
    let movie_coverUrl:URL?
    let movie_releasedDate:String?
    let movie_director:String?
    let movie_char:String?
    let movie_plot:String?
    let rating: [Rating]?
    
    enum codingKeys: String,CodingKey {
        case movie_name = "Title"
        case movie_year = "Year"
        case movie_coverUrl = "Poster"
        case movie_releasedDate = "Released"
        case movie_director = "Director"
        case movie_char = "Actors"
        case movie_plot = "Plot"
        case rating     = "Ratings"
        
        
    }
}
struct Rating:Decodable {
    
    let Source:String?
    let Value:String?
}
