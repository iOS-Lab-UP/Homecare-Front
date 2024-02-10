//
//  RoomListView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 08/02/24.
//

import SwiftUI

struct RoomListView: View {
    @EnvironmentObject var energyData: EnergyData
    
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
                    ForEach(energyData.rooms, id: \.id) { room in
                        RoomEnergySquare(room: room)
                            .frame(height: 180)
                            .cornerRadius(25)
                    }
                }
                .padding(.horizontal)
                BulbCounterCard()
                    .frame(height: 180)
                    .padding(.horizontal, padding)
                    .padding(.top, spacing)
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

struct BulbCounterCard: View {
    @EnvironmentObject var energyData: EnergyData
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.homecare)
            
            VStack {
                Text("Número de focos")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top)
                
                HStack(spacing: 40) {
                    Button(action: {
                        if energyData.numBulbs > 0 { energyData.numBulbs -= 1 }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    }
                    
                    Text("\(energyData.numBulbs)")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 80, alignment: .center)
                    
                    Button(action: {
                        energyData.numBulbs += 1
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}



#Preview {
    RoomListView()
}
