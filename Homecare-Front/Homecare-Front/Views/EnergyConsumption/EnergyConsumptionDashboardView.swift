//
//  EnergyConsumptionDashboardView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 08/02/24.
//

import SwiftUI
import DGCharts

struct EnergyConsumptionDashboardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Estadísticas de consumo de energía")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20.0)
            
            EnergyConsumptionPieChartView(percentage: 0.4, energyConsumed: 30)
                .padding(.leading, 110.0)
                .padding(.bottom, 20.0)
                .foregroundColor(.black)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .offset(y: 2)
                
                
                Text("Tu consumo de energía es 40% menor que el promedio de tu colonia")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            }.frame(width: 350, height: 80)

                
            
            EnergyConsumptionLineChartViewWrapper(yValues: [
                ChartDataEntry(x: 1.0, y: 10.0),
                ChartDataEntry(x: 2.0, y: 20.0),
                ChartDataEntry(x: 3.0, y: 25.0),
                ChartDataEntry(x: 4.0, y: 10.0),
                ChartDataEntry(x: 5.0, y: 12.0),
                ChartDataEntry(x: 6.0, y: 15.0),
                ChartDataEntry(x: 7.0, y: 8.0),
                ChartDataEntry(x: 8.0, y: 5.0),
                ChartDataEntry(x: 9.0, y: 28.0),
                ChartDataEntry(x: 10.0, y: 20.0),
                ChartDataEntry(x: 11.0, y: 35.0),
                ChartDataEntry(x: 12.0, y: 20.0)
            ])
        }.padding()
        
    }
}

#Preview {
    EnergyConsumptionDashboardView()
}
