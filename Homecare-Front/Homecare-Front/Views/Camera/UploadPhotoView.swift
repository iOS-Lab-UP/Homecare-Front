//
//  UploadCameraView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 08/02/24.
//



import SwiftUI
import AVFoundation
import UIKit

enum Picker {
    enum Source {
        case library, camera
    }
    
    // Actualizada para usar AVFoundation y manejar permisos de manera adecuada
    static func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // El usuario ha otorgado previamente el acceso
            completion(true)
        case .notDetermined:
            // El permiso no ha sido solicitado aún
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            // El usuario ha denegado previamente el acceso o está restringido
            completion(false)
        @unknown default:
            // Manejar casos desconocidos
            completion(false)
        }
    }
}


struct UploadPhotoView: View{
    @EnvironmentObject var vm: ViewModel
    @State private var navigateToDashboard = false
    @State private var showRoomsSheet = false
    @State private var navigateToARView = false  // State to control navigation to the AR view

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
                VStack{

                    HStack{
                        if vm.image != nil{
                            Button(action: {
                                analyzeImage(image: vm.image!)
                                showRoomsSheet.toggle()
                            }){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .foregroundStyle(Color.homecare)
                                    Text("Enviar foto")
                                        .foregroundStyle(Color.white)
                                }
                                .frame(height: 60)
                                .padding()
                            }
                            // NavigationLink is here, but it's hidden and only activated when navigateToDashboard is true
                            .background(
                                NavigationLink(destination: MainView(), isActive: $navigateToDashboard) {
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
                                        .foregroundStyle(Color.green.opacity(0.8))
                                    
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
                                        .foregroundStyle(Color.homecare)
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
                                        .foregroundStyle(Color.green.opacity(0.8))
                                    
                                    Image(systemName: "photo")
                                        .foregroundStyle(Color.black)
                                }
                                .padding()
                                
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .background(Color.white)
            .navigationTitle("Analizar caso")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(isPresented: $vm.showPicker){
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
                    .foregroundColor(.black
                    )
                
            }
            .sheet(isPresented: $showRoomsSheet){
                if let image = vm.image {
                    addToRoomsView(selectedImage: .constant(image)) // Pass the image as a binding
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            }
        }
        .background(Color.white) // Establece el color de fondo de la NavigationView a blanco
        .edgesIgnoringSafeArea(.all)
        
    }
}
#Preview {
    UploadPhotoView().environmentObject(ViewModel())
}

