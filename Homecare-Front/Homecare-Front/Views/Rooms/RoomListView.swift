import SwiftUI

struct RoomListView: View {
    @EnvironmentObject var energyData: EnergyData
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    private let spacing: CGFloat = 20
    private let padding: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tus publicaciones")
                .font(.title)
                .colorInvert()
                .padding(.leading, 20)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: spacing) {
                    // Usando solo los últimos dos elementos de la lista
                    ForEach(Array(energyData.rooms.suffix(2)), id: \.id) { room in
                        RoomEnergySquare(room: room)
                            .frame(height: 180)
                            .cornerRadius(25)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RoomEnergySquare: View {
    var room: Room
    
    var body: some View {
           ZStack(alignment: .bottomLeading) {
               Image(room.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: (UIScreen.main.bounds.width - (20 * 2) - 20) / 2, height: 180)
                   .cornerRadius(25)
                   .clipped()

               Text(room.name)
                   .font(.headline)
                   .fontWeight(.bold)
                   .foregroundColor(.white)
                   .padding()
        }
    }
}

// Asegúrate de que la instancia de EnergyData está inyectada correctamente para evitar errores en runtime
struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView().environmentObject(EnergyData())
    }
}
