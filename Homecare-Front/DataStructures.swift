//
//  DataStructures.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 09/02/24.
//

import Combine


class EnergyData: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    var kWhSaved: Int = 5 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var numBulbs: Int = 6 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var living_room_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var kitchen_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var bathroom_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var bedroom_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var home_office_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var garden_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    var bulbs_kWH: Int {
        Int(Double(numBulbs) * 0.045 * 8 * 60)
    }
    
    var kWhUsed: Int {
        bulbs_kWH + living_room_kWH + kitchen_kWH + bathroom_kWH + bedroom_kWH + home_office_kWH + garden_kWH
    }
    
    init() {}
}
