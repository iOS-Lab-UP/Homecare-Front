//
//  DataStructures.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 09/02/24.
//

import Foundation

class EnergyData: ObservableObject {
    @Published var kWhSaved: Int
    @Published var kWhUsed: Int
    
    @Published var numBulbs: Int
    
    init(kWhSaved: Int = 0, kWhUsed: Int = 0, numBulbs: Int = 5) {
        self.kWhSaved = kWhSaved
        self.kWhUsed = kWhUsed
        self.numBulbs = numBulbs
    }
}
