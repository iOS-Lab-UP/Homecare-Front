import SwiftUI


// Define a structure that holds an image and an ID.
struct Advertisement: Identifiable {
    let id: UUID
    let image: UIImage
    
    // Initialize with a UIImage, generating a new UUID as the ID.
    init(image: UIImage) {
        self.id = UUID()
        self.image = image
    }
}

// Convert globalData.advertisments to an array of Advertisement objects. inside a list


struct RoomListView: View {
    @EnvironmentObject var globalData: GlobalDataModel
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tus publicaciones")
                .font(.title)
                .colorInvert()
                .padding(.leading, 20)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    // Iterate over the array of advertisements
                    ForEach(globalData.advertisementsGallery) { advertisement in
                        AdvertisementSquare(advertisement: advertisement)
                            .frame(height: 180)
                            .cornerRadius(25)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
struct AdvertisementSquare: View {
    let advertisement: Advertisement
    
    var body: some View {
        Image(uiImage: advertisement.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(25)
        
        
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
