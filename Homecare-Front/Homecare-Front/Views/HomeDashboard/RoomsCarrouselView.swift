//
//  RoomsCarrouselView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import SwiftUI

struct Room {
    var name: String
    var imageName: String
    var energyConsumption: String
}


struct RoomsCarrouselView: View {
    let rooms: [Room] = [
        Room(name: "Sala de estar", imageName: "living_room", energyConsumption: "200 kWh"),
        Room(name: "Cocina", imageName: "kitchen", energyConsumption: "150 kWh"),
        Room(name: "Baño principal", imageName: "bathroom", energyConsumption: "100 kWh"),
        Room(name: "Dormitorio principal", imageName: "bedroom", energyConsumption: "250 kWh"),
        Room(name: "Oficina en casa", imageName: "home_office", energyConsumption: "300 kWh"),
        Room(name: "Jardín", imageName: "garden", energyConsumption: "50 kWh")
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Habitaciones")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading)
            
            HStack{Spacer()}
        }
        
        ScrollView(.horizontal, showsIndicators: true)
        {
            HStack(spacing:10){
                ForEach(rooms, id: \.name) { room in RoomEnergyCardView(room: room) }
            }.padding()
        }
        
        
    }
    
    
}




struct RoomEnergyCardView: View {
    var room: Room
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(room.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 300)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(room.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(room.energyConsumption)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
}


#Preview {
    RoomsCarrouselView()
}
