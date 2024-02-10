//
//  RoomsCarrouselView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import SwiftUI


struct RoomsCarrouselView: View {
    @EnvironmentObject var energyData: EnergyData
    
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
                ForEach(energyData.rooms, id: \.id) { room in
                    RoomEnergyCardView(room: room)
                }
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
                .frame(width: 250, height: 250)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                )
            
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
        .cornerRadius(20)
    }
}



#Preview {
    RoomsCarrouselView()
}
