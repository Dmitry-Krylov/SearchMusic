//
//  SearchResponse.swift
//  SearchMusic
//
//  Created by Елена Крылова on 02.09.2023.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
    
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String
    var artistName: String
    var artworkUrl60: String?
}
