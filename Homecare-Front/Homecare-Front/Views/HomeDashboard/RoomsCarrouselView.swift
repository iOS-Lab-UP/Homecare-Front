//
//  RoomsCarrouselView.swift
//  Nemesis-Front
//
//  Created by Luis Cedillo M on 23/04/24.
//

import SwiftUI


struct RoomsCarrouselView: View {
    @EnvironmentObject var energyData: EnergyData
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Promociones")
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
