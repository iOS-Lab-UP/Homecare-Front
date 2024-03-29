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
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hola, Enrique!👋")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("Bienvenido a Homecare")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.fill")
                        .padding(9)
                        .background(Circle().fill(Color.gray.opacity(0.5)))
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .font(.system(size: 20))
                }
                .padding()
                .padding(.top, 20)
                .padding(.bottom, 5)
                
                SuggestionsCardView()
                
                //                EnergyCardView()
                SmartStackView()
                    .padding(.leading, 10)
                    .padding(.trailing, 10 )
                RoomsCarrouselView()
                
            }
            .background(Color.white)
        }
    }
}


#Preview {
    HomeView()
}
