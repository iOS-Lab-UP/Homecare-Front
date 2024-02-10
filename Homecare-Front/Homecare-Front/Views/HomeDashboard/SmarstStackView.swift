import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var title: String
    var value: String
    var icon: String
}

struct SmartStackView: View {
    @EnvironmentObject var energyData: EnergyData
    
    @State private var cards: [Card] = [
        Card(title: "Energía Ahorrada", value: "30", icon: "leaf.arrow.circlepath"),
        Card(title: "Consumo Actual", value: "10", icon: "sun.max.fill"),
        Card(title: "Meta de Ahorro", value: "60 kWh", icon: "moon.stars.fill")
    ]
    
    @State private var offset: CGSize = .zero
    @State private var currentIndex: Int = 0

    var body: some View {
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
                                    self.changeCard(toRight: true)
                                } else if self.offset.width < -100 {
                                    self.changeCard(toRight: false)
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
    
    private func changeCard(toRight: Bool) {
        if toRight {
            currentIndex = currentIndex < cards.count - 1 ? currentIndex + 1 : 0
        } else {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : cards.count - 1
        }
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color.homecare)
                
                HStack(spacing: 20) {
                    Image(systemName: card.icon)
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    VStack(alignment: .leading) {
                        Text(card.title)
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Text(card.value)
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .frame(height: 200)
        }
        .padding()
    }
}

struct SmartStackView_Previews: PreviewProvider {
    static var previews: some View {
        SmartStackView().environmentObject(EnergyData())
    }
}
