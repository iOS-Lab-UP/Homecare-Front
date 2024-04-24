import SwiftUI

struct RoomsCarrouselView: View {
    @EnvironmentObject var energyData: EnergyData
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Promociones")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading)
            
            HStack{ Spacer() }
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 10) {
                    // Usando los tres primeros elementos de la lista
                    ForEach(Array(energyData.rooms.prefix(3)), id: \.id) { room in
                        RoomEnergyCardView(room: room)
                    }
                }
                .padding()
            }
        }
    }
}

struct RoomEnergyCardView: View {
    var room: Room
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(room.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)  // Cambiado de .fill a .fit
                .frame(width: 250, height: 250)  // Mantiene el tamaño del marco pero ajusta la imagen para que quepa completamente
                .background(Color.white)  // Establece el fondo de la imagen a blanco
                .clipped()  // Asegura que cualquier parte fuera del marco se recorte

            VStack(alignment: .leading) {
                Text(room.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(room.energyConsumption)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .background(Color.black.opacity(0.5)) // Fondo para mejorar la visibilidad del texto, ajustar según necesidad
    }
}


// Asegúrate de que la instancia de EnergyData está inyectada correctamente para evitar errores en runtime
struct RoomsCarrouselView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsCarrouselView().environmentObject(EnergyData())
    }
}
