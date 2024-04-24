//
//  addToRoomsView.swift
//  Homecare-Front
//
//  Created by Iñaki Sigüenza on 10/02/24.
//

import SwiftUI

struct addToRoomsView: View {
    
    @State private var inputText: String = ""
    @Binding var selectedImage: UIImage? // Binds to the selected image
       @State private var showARView: Bool = false
    var body: some View {
            VStack {
                TextField("Enter your text here", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Upload and Show AR") {
                    self.showARView = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $showARView) {
                    if let imageToDisplay = selectedImage {
                        ARViewContainer(selectedImage: imageToDisplay)
                    } else {
                        Text("No image selected")
                    }
                }
            }
        }
    }


