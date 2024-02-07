//
//  ContentView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 06/02/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Spacer()
        VStack {
            HStack{
                VStack{
                    Text("Hola, Carlos! 👋🏻")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                    // FIXME: usar poppins
                    // FIXME: pasar a leading
                    Text("Bienvenido a HomeCare")
                    // FIXME: checar weight y tamaño
                }
            }
            HStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(.black.opacity(0.75))
                                .frame(width: 350, height: 150)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
