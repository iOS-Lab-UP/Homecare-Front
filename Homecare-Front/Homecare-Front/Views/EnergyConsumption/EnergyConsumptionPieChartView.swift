//
//  EnergyConsumptionChartView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import SwiftUI

struct EnergyConsumptionPieChartView: View {
    @EnvironmentObject var energyData: EnergyData
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.blue.opacity(0.2))
            
            Circle()
                .trim(from: 0, to: 100)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.green]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
            VStack {
                Image(systemName: "lightbulb.min")
                    .foregroundColor(Color.yellow)
                Text("\(energyData.kWhUsed) kWh")
                    .font(.title)
                    .bold()
                Text("\(energyData.kWhUsed)%")
                    .opacity(0.5)
            }
        }
        .frame(width: 150, height: 150)
    }
}


#Preview {
    EnergyConsumptionPieChartView()
}
