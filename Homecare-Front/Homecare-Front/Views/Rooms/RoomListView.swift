//
//  RoomListView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 08/02/24.
//

import SwiftUI

struct RoomListView: View {
    let rooms: [Room] = [
        Room(name: "Sala de estar", imageName: "living_room", energyConsumption: "200 kWh"),
        Room(name: "Cocina", imageName: "kitchen", energyConsumption: "150 kWh"),
        Room(name: "Baño principal", imageName: "bathroom", energyConsumption: "100 kWh"),
        Room(name: "Dormitorio principal", imageName: "bedroom", energyConsumption: "250 kWh"),
        Room(name: "Oficina en casa", imageName: "home_office", energyConsumption: "300 kWh"),
        Room(name: "Jardín", imageName: "garden", energyConsumption: "50 kWh")
    ]
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    private let spacing: CGFloat = 20
    private let padding: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tus habitaciones")
                .font(.title)
                .padding(.leading, 20)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(rooms, id: \.name) { room in
                        RoomEnergySquare(room: room)
                            .frame(width: (UIScreen.main.bounds.width - (padding * 2) - spacing) / 2, height: 180)
                            .cornerRadius(25)
                            .padding(.bottom, spacing)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RoomEnergySquare: View {
    var room: Room
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(room.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (UIScreen.main.bounds.width - (20 * 2) - 20) / 2, height: 180)
                .cornerRadius(25)
                .clipped()
            
            LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(25)
            
            Text(room.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
    }
}


#Preview {
    RoomListView()
}
