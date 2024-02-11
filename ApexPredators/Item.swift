//
//  Item.swift
//  ApexPredators
//
//  Created by Gaurav Rawat on 2024-02-11.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
