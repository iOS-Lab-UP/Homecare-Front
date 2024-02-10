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
    
    init(kWhSaved: Int = 5, kWhUsed: Int = 50) {
        self.kWhSaved = kWhSaved
        self.kWhUsed = kWhUsed
    }
}
