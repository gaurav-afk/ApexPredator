//
//  ApexPredetor.swift
//  ApexPredators
//
//  Created by Gaurav Rawat on 2024-02-11.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable{
    
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScenes]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScenes: Decodable, Identifiable{
        let id: Int
        let movie: String
        let sceneDescription: String
    }    

}

enum PredatorType: String, Decodable, CaseIterable, Identifiable{
    case all
    case land
    case air
    case sea
    
    var id: PredatorType {self}
    
    var background: Color{
        switch self{
        case .land: .brown
        case .air: .teal
        case .sea: .blue
        case .all: .black
        }
    }
        
    var icon: String{
        switch self{
        case .all: "square.stack.3d.up.fill"
        case .land: "leaf.fill"
        case .air: "wind"
        case .sea: "drop.fill"
        }
    }
}


enum Movies: String, Decodable, CaseIterable, Identifiable{
    case all
    case JurassicPark
    case TheLostWorldJurassicPark
    case JurassicParkIII
    case JurassicWorld
    case JurassicWorldFallenKingdom
    case JurassicWorldDominion
   
    
    var id: Movies {self}
    
    var movieName: String{
        switch self{
        case .all: "All"
        case .JurassicPark: "Jurassic Park"
        case .TheLostWorldJurassicPark: "The Lost World: Jurassic Park"
        case .JurassicParkIII: "Jurassic Park III"
        case .JurassicWorld: "Jurassic World"
        case .JurassicWorldFallenKingdom: "Jurassic World: Fallen Kingdom"
        case .JurassicWorldDominion: "Jurassic World: Dominion"
        }
    }
}
