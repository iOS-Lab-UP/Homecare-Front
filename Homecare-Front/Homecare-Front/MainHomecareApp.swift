//
//  MainHomecareApp.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import CoreML
import SwiftUI


struct MainView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        VStack {
            switch selectedTab {
            case 1:
                HomeView()
            case 2:
                EnergyConsumptionPieChartView(percentage: 0.4, energyConsumed: 30)
            case 3:
                HomeView()

            case 4:
                HomeView()

            case 5:
                HomeView()

            default:
                HomeView()
            }
            
            Spacer()
            
            ToolBar(selectedTab: $selectedTab)
        }
        .padding(.bottom, 20)
        .ignoresSafeArea()
        .background(Color.white)
    }
}


@main
struct MainHomecareApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}



