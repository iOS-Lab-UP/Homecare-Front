//
//  SuggestionsCardView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 10/02/24.
//

import SwiftUI

struct SuggestionsCardView: View {
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.8)]),
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(height: 150)
                    .shadow(radius: 5)
                
                VStack {
                    Image(systemName: "leaf.arrow.circlepath")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                        .padding(.top, 10)
                    
                    Text("EcoGenio")  // GreenGuru // PlanePal
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 5)
                    
                    Text("Vamos, juntos podemos marcar la diferencia! 🌱 Apaga las luces cuando salgas de una habitación. 💡")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 5)
                }
            }
            .padding(.horizontal, 16)
        }
    }
