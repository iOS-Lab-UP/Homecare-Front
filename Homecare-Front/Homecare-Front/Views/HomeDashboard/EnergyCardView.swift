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
                    .fill(Color.homecare)
                
                
                
                HStack {
                    Image("bolt.vector")
                        .padding(.horizontal, 16.0)
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        
                        Text("Energía ahorrada")
                            .font(.caption)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Text("40%")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                        
                        Text("30 kWh")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 10.0)
                    
                }.padding()
            }
            
            .frame(height: 100)
        }
        .padding()
    }
}

#Preview {
    EnergyCardView()
}
