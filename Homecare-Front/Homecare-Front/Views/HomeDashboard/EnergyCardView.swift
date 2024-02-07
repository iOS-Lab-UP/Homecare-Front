//
//  EnergyCardView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import SwiftUI

struct EnergyCardView: View {
    var body: some View {
        VStack() {

            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .shadow(radius: 10)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text("Energía ahorrada")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    
                    Text("40%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("30 kWh")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.7))
                    
                    HStack {
                        Spacer()
                        // Arrow or "chevron" icon
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.all)
            }
            .frame(height: 100)
        }
        .padding()
    }
}

#Preview {
    EnergyCardView()
}
