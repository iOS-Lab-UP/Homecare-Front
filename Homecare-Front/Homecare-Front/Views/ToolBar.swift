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
        HStack(alignment: .center) {
            
            TabBarButton(icon: "house", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            
            
            TabBarButton(icon: "bolt.horizontal", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
            
            
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
                    .clipShape(Rectangle())
                    .cornerRadius(10)
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
        .background(Capsule().fill(Color.homecare.opacity(0.8)))
        .shadow(color: .homecare, radius: 5, x: 0, y: 3)
        
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




#Preview {
    ToolBar(selectedTab: .constant(1))
}
