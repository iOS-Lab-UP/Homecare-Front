//
//  ContentView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 06/02/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                // Welcome message
                VStack(alignment: .leading) {
                    Text("Bienvenido, Enrique!👋")
                        .font(.system(size: 25))
                        .fontWeight(.bold)

                    Text("Bienvenido a Homecare")
                        .font(.subheadline)
                }
                .padding([.leading, .trailing])
                
                // Profile
                Image(systemName: "person.fill")
                .padding(9)
                .background(Circle().fill(Color.gray.opacity(0.5)))
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .font(.system(size: 20))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 15)
            
            EnergyCardView().padding(.bottom)
            RoomsCarrouselView()
        }.padding(.top, 20)
        ToolBar(selectedTab: .constant(1))

        
    }
}

#Preview {
    HomeView()
}
