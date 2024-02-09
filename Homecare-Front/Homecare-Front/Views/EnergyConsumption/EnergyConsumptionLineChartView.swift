//
//  EnergyConsumptionLineChartView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 08/02/24.
//

import DGCharts
import SwiftUI



struct EnergyConsumptionLineChartViewWrapper: UIViewRepresentable {
    let yValues: [ChartDataEntry]

    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()
        
        // Chart properties
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
        chartView.animate(xAxisDuration: 1.5)
        chartView.drawGridBackgroundEnabled = false
        chartView.pinchZoomEnabled = true
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        // YAxis properties
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.labelTextColor = .gray
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        
        
        // XAxis properties
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.axisLineColor = .systemCyan
        xAxis.labelTextColor = .gray
    
       
        
        chartView.delegate = context.coordinator
        return chartView
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: yValues, label: "Energy Consumption")
        
        let gradientColors = [ChartColorTemplates.colorFromString("#5EC6FD").cgColor,
                              ChartColorTemplates.colorFromString("#07FAA3").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        // Line properties
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.mode = .cubicBezier
        dataSet.fillAlpha = 0.7
        dataSet.drawFilledEnabled = true
        dataSet.highlightColor = UIColor(red: 0/255, green: 200/255, blue: 117/255, alpha: 1)
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        
       
        
        let data = LineChartData(dataSet: dataSet)
        uiView.data = data
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ChartViewDelegate {
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            print(entry)
        }
    }
}

#Preview
{
    EnergyConsumptionLineChartViewWrapper(yValues: [
        ChartDataEntry(x: 1.0, y: 10.0),
        ChartDataEntry(x: 2.0, y: 20.0),
        ChartDataEntry(x: 3.0, y: 15.0),
        ChartDataEntry(x: 4.0, y: 25.0),
        ChartDataEntry(x: 5.0, y: 18.0),
        ChartDataEntry(x: 6.0, y: 30.0),
        ChartDataEntry(x: 7.0, y: 22.0),
        ChartDataEntry(x: 8.0, y: 35.0),
        ChartDataEntry(x: 9.0, y: 28.0),
        ChartDataEntry(x: 10.0, y: 40.0),
        ChartDataEntry(x: 11.0, y: 32.0),
        ChartDataEntry(x: 12.0, y: 45.0),

        // Add more data points here if needed
    ])
}


