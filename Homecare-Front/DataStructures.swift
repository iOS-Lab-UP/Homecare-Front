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
    
    
    var kWhSaved: Int = 0 { // TODO: Determine
        willSet {
            objectWillChange.send()
        }
        didSet {
            updateRooms()
        }
    }
    
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
        Int(Double(numBulbs) * 0.045 * 8 * 60)
    }
    
    var kWhUsed: Int {
        bulbs_kWH + living_room_kWH + kitchen_kWH + bathroom_kWH + bedroom_kWH + home_office_kWH + garden_kWH
    }
    
    init() {
        updateRooms()
    }
    
    func updateRooms() {
        rooms = [
            Room(name: "Sala de estar", imageName: "living_room", energyConsumption: "\(living_room_kWH) kWh"),
            Room(name: "Cocina", imageName: "kitchen", energyConsumption: "\(kitchen_kWH) kWh"),
            Room(name: "Baño principal", imageName: "bathroom", energyConsumption: "\(bathroom_kWH) kWh"),
            Room(name: "Dormitorio principal", imageName: "bedroom", energyConsumption: "\(bedroom_kWH) kWh"),
            Room(name: "Oficina en casa", imageName: "home_office", energyConsumption: "\(home_office_kWH) kWh"),
            Room(name: "Jardín", imageName: "garden", energyConsumption: "\(garden_kWH) kWh")
        ]
    }
    
    
}
