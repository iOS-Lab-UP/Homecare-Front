//
//  EnergyCardView.swift
//  Nemesis-Front
//
//  Created by Luis Cedillo M on 23/04/24.
//

import SwiftUI

struct EnergyCardView: View {
    @EnvironmentObject var energyData: EnergyData
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color.black)
                
                HStack {
                    Image("bolt.vector")
                        .padding(.horizontal, 16.0)
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        HStack {
                            Spacer()
                        }
                    }
                    .padding(.leading, 10.0)
                }.padding()
            }
            .frame(height: 60)
        }
        .padding()
    }
}


#Preview {
    EnergyCardView()
}
