//
//  ResultListModel.swift
//  MercadoLivre-Teste
//
//  Created by Pedro Lopes on 08/03/21.
//  Copyright © 2021 Pedro Lopes. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    
    var searchResults: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case searchResults = "results"
    }
}

struct SearchResult: Codable {
    
    var title: String!
    var price: Double!
    var condition: String!
    var thumbnail: String!
    var permalink: String!
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
        case condition
        case thumbnail
        case permalink
    }
}
