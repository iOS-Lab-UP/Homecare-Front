//
//  RoomListView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 08/02/24.
//

import SwiftUI

struct RoomListView: View {
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
        private let spacing: CGFloat = 20
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Rooms")
                .font(.title)
                .padding(.leading, 20)
                .fontWeight(.bold)
                .foregroundColor(.black)
                
            
            ScrollView {
                // Use LazyVGrid for a flexible grid layout
                LazyVGrid(columns: columns, spacing: spacing) {
                    // Generate multiple rounded rectangles
                    ForEach(0..<5, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                            .frame(height: 180)
                            .padding(.bottom, spacing)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    RoomListView()
}
