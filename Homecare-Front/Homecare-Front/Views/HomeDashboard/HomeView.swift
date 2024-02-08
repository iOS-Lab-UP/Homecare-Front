//
//  ContentView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 06/02/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the white background to cover the entire screen

            VStack(alignment: .leading) {
                HStack {
                    // Welcome message
                    VStack(alignment: .leading) {
                        Text("Hola, Enrique!👋")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("Bienvenido a Homecare")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding([.leading, .trailing])
                    
                    Spacer()
                    
                    // Profile
                    Image(systemName: "person.fill")
                        .padding(9)
                        .background(Circle().fill(Color.gray.opacity(0.5)))
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .font(.system(size: 20))
                }
                .padding(.all, 20)
                .padding(.bottom, 15)
                
                EnergyCardView()
                    .padding(.bottom, 40)
                RoomsCarrouselView()
                ToolBar(selectedTab: .constant(1))
                    .padding(.leading, 25.0)

            }
            .background(Color.white) // Ensure the VStack also has a white background
            
               
        }
    }
}


#Preview {
    HomeView()
}
