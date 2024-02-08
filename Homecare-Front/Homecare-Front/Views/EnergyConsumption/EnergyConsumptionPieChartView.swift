//
//  EnergyConsumptionChartView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import SwiftUI
import Charts

struct EnergyConsumptionPieChartView: View {
    var percentage: CGFloat // The completion percentage of the circle (0.0 to 1.0)
    var energyConsumed: Int // The energy consumption in kWh

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.blue.opacity(0.2))
                    
                    // Foreground circle representing the progress with a gradient hue
                    Circle()
                        .trim(from: 0, to: percentage)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.green]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .rotationEffect(Angle(degrees: -90)) // Start the circle from the top
            
            // Center text
            VStack {
                Image(systemName: "lightbulb.min")
                    .foregroundColor(Color.yellow)
                Text("\(energyConsumed) kWh")
                    .font(.title)
                    .bold()
                Text("\(Int(percentage * 100))%")
                    .opacity(0.5)
            }
        }
        .frame(width: 150, height: 150)
    }
}


#Preview {
    EnergyConsumptionPieChartView(percentage: 0.6, energyConsumed: 30) // Example usage
}
