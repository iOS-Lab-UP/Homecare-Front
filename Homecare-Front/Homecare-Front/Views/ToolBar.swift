//
//  ToolBar.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//
import SwiftUI

struct ToolBar: View {
    @Binding var selectedTab: Int
    var body: some View {
        switch selectedTab {
        case 1:
            HomeView()
        case 2:
            LightningView()
        case 3:
            PlusActionView()
        case 4:
            LampView()
        case 5:
            SettingsView()
        default:
            Text("Seleccione una opción")
        }
        
        
        HStack(alignment: .center) {
            TabBarButton(icon: "house", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            
            TabBarButton(icon: "bolt.horizontal", isSelected: selectedTab == 2) {
                selectedTab = 2
                
            }
            
            // Raised button for the "Plus" action
            Button(action: { selectedTab = 3 }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(4)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green.opacity(0.8), Color.yellow.opacity(0.8)]),
                            startPoint: UnitPoint(x: 0.5, y: 0.3),
                            endPoint: UnitPoint.bottom
                        )
                    )
                    .clipShape(Circle())
                    .shadow(color: .green, radius: 3)
                    .font(.system(size: 35))
            }
            
            TabBarButton(icon: "lamp.floor", isSelected: selectedTab == 4) {
                selectedTab = 4
            }
            
            TabBarButton(icon: "gearshape", isSelected: selectedTab == 5) {
                selectedTab = 5
            }
        }
        
        .frame(width: UIScreen.main.bounds.width - 50, height: 56, alignment: .top)
        .background(Capsule().fill(Color.gray.opacity(0.8))) // Cambiado a gris para evitar errores si Color.homecare no está definido
        .shadow(color: .gray, radius: 5, x: 0, y: 3) // Cambiado a gris por la misma razón
    }
}

struct LightningView: View {
    var body: some View {
        Text("Lightning View")
    }
}

struct PlusActionView: View {
    var body: some View {
        Text("Plus Action View")
    }
}

struct LampView: View {
    var body: some View {
        Text("Lamp View")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings View")
    }
}

struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(isSelected ? .green : .gray)
                .font(.system(size: 20, weight: .bold))
                .padding()
        }
    }
}
