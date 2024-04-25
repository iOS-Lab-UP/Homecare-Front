//
//  DataStructures.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 09/02/24.
//

import Foundation
import Combine

struct Room: Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var energyConsumption: String
}


class EnergyData: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var rooms: [Room] = []
    
    var numBulbs: Int = 0 {
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
    var living_room_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
    var kitchen_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
    var bathroom_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
    var bedroom_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
    var home_office_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
    var garden_kWH: Int = 0 {
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
    var bulbs_kWH: Int {
        Int(Double(numBulbs) * 0.045 * 8 * 30)
    }
    
    var kWhUsed: Int {
        bulbs_kWH + living_room_kWH + kitchen_kWH + bathroom_kWH + bedroom_kWH + home_office_kWH + garden_kWH
    }
    
    var percentageSaved: Double {
        ((200 - Double(kWhUsed)) / 200 ) * 100
    }
    
    var co2 : Double {
        0.423 * Double(kWhUsed)
    }
    
    init() {
        updateRooms()
    }
    
    func updateRooms() {
        rooms = [

            Room(name: "", imageName: "Jumex", energyConsumption: ""),
            Room(name: "", imageName: "Cerveza", energyConsumption: ""),
            Room(name: "", imageName: "Tang", energyConsumption: ""),
            Room(name: "", imageName: "Promo", energyConsumption: ""),
            Room(name: "", imageName: "Gato_baboso", energyConsumption: ""),
            Room(name: "", imageName: "santa", energyConsumption: "")
            
        ] 
    }
    
    
}

