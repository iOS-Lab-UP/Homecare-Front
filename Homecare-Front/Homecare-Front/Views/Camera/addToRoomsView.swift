//
//  addToRoomsView.swift
//  Homecare-Front
//
//  Created by Iñaki Sigüenza on 10/02/24.
//

import SwiftUI

struct addToRoomsView: View {
    
    @State var rooms = [1,2,3]
    
    var body: some View {
        List{
            ForEach(rooms.indices){
                room in
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray.opacity(0.2))
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                                
                            
                            Image(systemName: "house")
                                .foregroundStyle(Color.blue)
                                .font(.title2)
                            
                            
                        }
                        .frame(width: 55, height: 55)
                        
                        VStack(alignment: .leading){
                            Text("Living Rom")
                                .bold()
                            Text("x accesorios")
                        }
                    }
                    .padding()
                }
                .frame(height: 50)
                .padding(.vertical, 10)
                .listRowSeparator(.hidden)
                
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    addToRoomsView()
}
