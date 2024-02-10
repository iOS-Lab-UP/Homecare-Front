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
                ZStack {
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
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Image(systemName: "person.fill")
                            .padding()
                            .background(Circle().fill(Color.gray.opacity(0.5)))
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .font(.system(size: 20))
                    }
                }
                .padding(.top, 10)

                SuggestionsCardView()
                    .padding(.vertical, 20)
                
                SmartStackView()
                    .padding(.vertical, 20)
                
                RoomsCarrouselView()
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        
    }
}

#Preview {
    HomeView()
}
