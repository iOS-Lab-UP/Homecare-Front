import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0) // Default color
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}


struct Card: Identifiable {
    let id = UUID()
    var title: String
    var value: String
    var icon: String
    var backgroundColor: Color
}

struct SmartStackView: View {
    @EnvironmentObject var energyData: EnergyData
    
    @State private var offset: CGSize = .zero
    @State private var currentIndex: Int = 0
    
    var body: some View {
        let cards = generateCards()
        
        ZStack {
            ForEach(cards.indices.reversed(), id: \.self) { index in
                CardView(card: cards[index])
                    .offset(x: self.currentIndex == index ? self.offset.width : 0, y: 0)
                    .rotationEffect(.degrees(Double(self.offset.width / 100)))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.offset = gesture.translation
                            }
                            .onEnded { _ in
                                if self.offset.width > 100 {
                                    self.changeCard(toRight: true, count: cards.count)
                                } else if self.offset.width < -100 {
                                    self.changeCard(toRight: false, count: cards.count)
                                }
                                self.offset = .zero
                            }
                    )
                    .animation(.spring())
                    .zIndex(self.currentIndex == index ? 1 : 0)
            }
        }
        .padding()
    }
    
    
    private func generateCards() -> [Card] {
        return [
            Card(title: "Post nuevos", value: "10 Post nuevos", icon: "newspaper.fill", backgroundColor: Color(hex: "#E43C3C")), // Ejemplo con un rojo tomate
            Card(title: "Puntos (inserte nombre de la app) by oxxo ", value: "\(formatValue(Double(energyData.kWhUsed))) kWh", icon: "bolt.fill", backgroundColor: Color(hex: "#FFC038")), // Un azul acero
        ]
    }

    
    
    private func changeCard(toRight: Bool, count: Int) {
        if toRight {
            currentIndex = currentIndex < count - 1 ? currentIndex + 1 : 0
        } else {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : count - 1
        }
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(card.backgroundColor)
                HStack(spacing: 10) {
                    Image(systemName: card.icon)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        Text(card.title)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Text(card.value)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                    }
                    
                    Spacer()
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(height: 120)
        }
    }
}

func formatValue(_ value: Double) -> String {
    return String(format: "%.2f", value)
}

struct SmartStackView_Previews: PreviewProvider {
    static var previews: some View {
        SmartStackView().environmentObject(EnergyData())
    }
}
