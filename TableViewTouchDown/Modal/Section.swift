//
//  Section.swift
//  TableViewTouchDown
//
//  Created by Ammy Pandey on 25/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import Foundation

class Section {
    
    var genere: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genere: String, movies: [String], expanded: Bool) {
        self.genere = genere
        self.movies = movies
        self.expanded = expanded
    }
}
