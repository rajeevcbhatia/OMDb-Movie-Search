//
//  Movie.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import Foundation

struct Root: Codable {
    var Search: [OMDbItem]
}

struct OMDbItem: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case posterUrlString = "Poster"
        case plot = "Plot"
    }
    
    let title: String?
    let year: String?
    let id: String
    let posterUrlString: String?
    let type: String?
    let plot: String?
    
}
