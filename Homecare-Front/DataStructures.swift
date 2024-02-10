//
//  DataStructures.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 09/02/24.
//

import Foundation

class EnergyData: ObservableObject {
    @Published var energySavedPercentage: Int
    @Published var kWhSaved: Int
    
    init(energySavedPercentage: Int = 0, kWhSaved: Int = 0) {
        self.energySavedPercentage = energySavedPercentage
        self.kWhSaved = kWhSaved
    }
}
