//
//  EnergyConsumptionDashboardView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 08/02/24.
//

import SwiftUI
import DGCharts

struct EnergyConsumptionDashboardView: View {
    var chartDataEntries = [ChartDataEntry]()
    var consumptionPerMonth = GlobalDataModel.shared.predictionData
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Estadísticas de consumo de energía")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20.0)
            
            EnergyConsumptionPieChartView()
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
            



            let chartDataEntries = generateChartDataEntries(withPredictions: consumptionPerMonth)

            
            
            EnergyConsumptionLineChartViewWrapper(yValues: chartDataEntries)
        }.padding()
        
    }
    
    func generateChartDataEntries(withPredictions predictions: [Double]) -> [ChartDataEntry] {
        // Ensure the predictions array starts with x values from 1.0, incrementing by 1 for each prediction
        let entries = predictions.enumerated().map { index, prediction in
            ChartDataEntry(x: Double(index + 1), y: prediction)
        }
        return entries
    }


    
}

#Preview {
    EnergyConsumptionDashboardView()
}
