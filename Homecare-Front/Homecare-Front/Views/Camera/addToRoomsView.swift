//
//  addToRoomsView.swift
//  Homecare-Front
//
//  Created by Iñaki Sigüenza on 10/02/24.
//

import SwiftUI

struct addToRoomsView: View {
    
    @State private var inputText: String = ""
    @State private var showARView: Bool = false  // State to control modal presentation

    var body: some View {
        VStack {
            TextField("Enter your text here", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Upload and Show AR") {
                self.showARView = true  // Toggle visibility of AR view
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $showARView) { // Present AR view as a modal sheet
                ARViewContainer()
            }
        }
    }
}

func uploadText(inputText: String) {
    // Function to upload the text to the rooms
    ARViewContainer().edgesIgnoringSafeArea(.all)
}

#Preview {
    addToRoomsView()
}


