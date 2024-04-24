import SwiftUI

struct addToRoomsView: View {
    @State private var inputText: String = ""
    @State private var title: String = ""
    @Binding var selectedImage: UIImage? // Binds to the selected image
    @State private var showARView: Bool = false // Controls the navigation link
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title here", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Enter description here", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Upload and Show AR") {
                    guard let image = selectedImage else {
                        print("No image selected")
                        return
                    }
                    
                    // Trigger image upload and handle response
                    uploadImage(title: title, description: inputText, image: image) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let response):
                                print("Image uploaded successfully: \(response)")
                                self.showARView = true // Activate NavigationLink
                            case .failure(let error):
                                print("Upload failed with error: \(error)")
                            }
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // Navigation Link hidden but activated based on showARView state
                NavigationLink(destination: SwiftUIView(), isActive: $showARView) {
                    EmptyView() // Invisible in UI but functional for navigation
                }
            }
        }
    }
    
}
