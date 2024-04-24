import SwiftUI

struct ToolBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(alignment: .center) {
            TabBarButton(icon: "house", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            
            TabBarButton(icon: "mappin", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
            
            Button(action: { selectedTab = 3 }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.red.opacity(0.8), Color.yellow.opacity(0.8)]),
                            startPoint: UnitPoint(x: 0.5, y: 0.3),
                            endPoint: UnitPoint.bottom
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 40, height: 40)
            }
            
            TabBarButton(icon: "note", isSelected: selectedTab == 4) {
                selectedTab = 4
            }
            
            TabBarButton(icon: "cube.transparent", isSelected: selectedTab == 5) {
                selectedTab = 5
            }
        }
        .padding(.horizontal, 10)  // Ajusta el padding para evitar que la barra se pegue a los bordes
        .frame(width: UIScreen.main.bounds.width - 40, height: 56, alignment: .center) // Establece un ancho menor que el de la pantalla
        .background(Capsule().fill(Color.black.opacity(0.8)))
        .shadow(color: .black, radius: 5, x: 0, y: 3)
    }
}

struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(isSelected ? .yellow : .gray)
                .font(.system(size: 20, weight: .bold))
                .padding()
        }
    }
}

#Preview {
    ToolBar(selectedTab: .constant(1))
}
