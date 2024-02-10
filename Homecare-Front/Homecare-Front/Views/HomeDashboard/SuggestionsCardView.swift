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
            
            HStack {
                Image(systemName: "leaf.arrow.circlepath")
                    .font(.system(size: 40))
                    .foregroundColor(.yellow)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("EcoGenio")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Vamos, juntos podemos marcar la diferencia! 🌱 Apaga las luces cuando salgas de una habitación. 💡")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 240, alignment: .leading)
                }
                .padding(.leading, 10)
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
}

struct SuggestionsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsCardView()
    }
}
