//
//  RoomsCarrouselView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import SwiftUI

struct RoomsCarrouselView: View {
    let numberOfCards = 10

    var body: some View {
        VStack(alignment: .leading){
            Text("Habitaciones")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            HStack{Spacer()}
        }
        
        ScrollView(.horizontal, showsIndicators: true)
        {
            HStack(spacing:10){
                // Carrousel with RoomEnergyCardView
                ForEach(0..<numberOfCards, id: \.self) { _ in
                        RoomEnergyCardView()
                    }
                }.padding()
        }
        
        
        }
    
        
    }




struct RoomEnergyCardView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background image
            Image("living_room") // Replace with your image name
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 400) // Adjust the size as needed
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20))
            
            // Text overlay
            VStack(alignment: .leading) {
                Text("Sala de estar")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("0000 kWh")
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
