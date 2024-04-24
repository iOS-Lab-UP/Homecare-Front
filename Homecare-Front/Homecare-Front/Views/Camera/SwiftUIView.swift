import SwiftUI



struct SwiftUIView: View {
    @ObservedObject var dataModel = GlobalDataModel.shared

    var body: some View {
        VStack {
            if let adImage = dataModel.advertisement {
                Image(uiImage: adImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("No Advertisement Available")
            }
            Text(dataModel.advicePrompt) // Display advice prompt
        }
    }
}

// Preview
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
