//
//  addToRoomsView.swift
//  Homecare-Front
//
//  Created by Iñaki Sigüenza on 10/02/24.
//

import SwiftUI

struct addToRoomsView: View {
    
    @State private var inputText: String = ""
    @State private var title: String = ""
    @Binding var selectedImage: UIImage? // Binds to the selected image
    @State private var showARView: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    var staticImage: UIImage?


    var body: some View {
        VStack {
            TextField("Enter title here", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter description here", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Upload and Show AR") {
                guard let image = selectedImage else {
                    alertMessage = "No image selected"
                    showAlert = true
                    return
                }
                
                uploadImage(title: title, description: inputText, image: image) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            print("Image uploaded successfully: \(response)")
                            showARView = true
                        case .failure(let error):
                            print("Upload failed with error: \(error)") // Only log the error
                            showARView = true // Optionally continue to show the AR view regardless of the error
                        }
                    }
                }

            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showARView) {
                ARViewContainer(selectedImage: Binding.constant(staticImage))

            }        }
    }
}
