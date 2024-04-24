//
//  RoomListView.swift
//  Nemesis-Front
//
//  Created by Enrique Gómez Tagle on 23/04/24.
//

import SwiftUI

struct RoomListView: View {
    @EnvironmentObject var energyData: EnergyData
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    private let spacing: CGFloat = 20
    private let padding: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tus publicaciones")
                .font(.title)
                .padding(.leading, 20)
                .fontWeight(.bold)

            
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(energyData.rooms, id: \.id) { room in
                        RoomEnergySquare(room: room)
                            .frame(height: 180)
                            .cornerRadius(25)
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
