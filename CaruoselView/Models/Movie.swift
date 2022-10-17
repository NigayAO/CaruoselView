//
//  Moview.swift
//  CaruoselView
//
//  Created by Alik Nigay on 17.10.2022.
//

import Foundation

struct Movie: Identifiable, Equatable {
    let id: UUID = UUID()
    
    let name: String
    let poster: String
    
    static func getMovies() -> [Movie] {
        [
            Movie(name: "Aladin", poster: "aladin"),
            Movie(name: "Brother", poster: "bro"),
            Movie(name: "Dune", poster: "dune"),
            Movie(name: "Sonic", poster: "sonic")
        ]
    }
}
