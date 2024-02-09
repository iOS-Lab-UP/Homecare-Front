//
//  UploadCameraView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 08/02/24.
//



import SwiftUI

import UIKit

enum Picker {
    enum Source {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            return true
        } else {
            return false
        }
    }
}

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    
    func showPhotoPicker() {
        if source == .camera {
            if !Picker.checkPermissions() {
                print("Este dispositivo no tiene camara")
                return
            }
        }
        showPicker = true
    }
}


struct UploadPhotoView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var navigateToDashboard = false
    var body: some View {
        NavigationView {
            VStack{
                
                if let image = vm.image {
                    Spacer()
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    /*ZoomableScrollView {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }*/
                    
                } else {
                    LottieView(url: Bundle.main.url(forResource: "photo", withExtension: "lottie")!)
                    
                }
                Spacer()
                HStack{
                    if vm.image != nil{
                        Button(action: {
                          
                            navigateToDashboard = true
                                        }){
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 20.0)
                                                    .foregroundStyle(Color("blackish"))
                                                Text("Enviar foto")
                                                    .foregroundStyle(Color.white)
                                            }
                                            .frame(height: 60)
                                            .padding()
                                        }
                                        // NavigationLink is here, but it's hidden and only activated when navigateToDashboard is true
                                        .background(
                                            NavigationLink(destination: HomeView(), isActive: $navigateToDashboard) {
                                                EmptyView()
                                            }
                                            .hidden()
                                        )
                        
                
                            Menu {
                                        Button {
                                            vm.source = .camera
                                            vm.showPhotoPicker()
                                        } label: {
                                            Label("Tomar otra foto", systemImage: "camera")
                                        }
                                        
                                        Button {
                                            vm.source = .library
                                            vm.showPhotoPicker()
                                        } label: {
                                            Label("Elegir otra foto", systemImage: "photo")
                                        }
                                    } label: {
                                        ZStack{
                                            Circle()
                                                .frame(width: 60, height: 60)
                                                .foregroundStyle(Color("yellowsito"))
                                            
                                            Image(systemName: "arrow.triangle.2.circlepath")
                                                .foregroundStyle(Color.black)
                                        }
                                        .padding()
                                    }
                            
                        
                    } else {
                        
                        Button(action: {
                            vm.source = .camera
                            vm.showPhotoPicker()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20.0)
                                    .foregroundStyle(Color("blackish"))
                                Text("Tomar foto")
                                    .foregroundStyle(Color.white)
                            }
                            .frame(height: 60)
                            .padding()
                            
                        }
                        
                        Button(action: {
                            vm.source = .library
                            vm.showPhotoPicker()
                        }){
                            ZStack{
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(Color("yellowsito"))
                                
                                Image(systemName: "photo")
                                    .foregroundStyle(Color.black)
                            }
                            .padding()
                            
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Analizar caso")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(isPresented: $vm.showPicker){
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
                    .background(Color.white)
                
        }
        }
        
    }
}
#Preview {
    UploadPhotoView()
}

