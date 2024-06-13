//
//  VideoType.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import Foundation

enum VideoType: Int {
    case movies = 0
    case series = 1
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .series:
            return "Series"
        }
    }
    
    var url: String {
        switch self {
        case .movies:
            return "movie"
        case .series:
            return "tv"
        }
    }
}
