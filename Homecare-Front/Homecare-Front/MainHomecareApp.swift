//
//  MainHomecareApp.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import CoreML
import DGCharts
import SwiftUI


struct MainView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        VStack {
            switch selectedTab {
            case 1:
                HomeView()
            case 2:
                EnergyConsumptionDashboardView()
            case 3:
                CFEOCRView()

            case 4:
                RoomListView()

            case 5:
                SettingsView()

            default:
                HomeView()
            }
            
            
            ToolBar(selectedTab: $selectedTab)
        }
        .padding(.bottom, 20)
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

#Preview{
    MainView()
}



