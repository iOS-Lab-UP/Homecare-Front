import SwiftUI
import AVFoundation
import UIKit

enum Picker {
    enum Source {
        case library, camera
    }
    
    static func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
}

struct UploadPhotoView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var showRoomsSheet = false
    @State private var navigateToDashboard = false
    @State private var navigateToARView = false  // State to control navigation to the AR view
    @State private var photoDescription = ""  // State for storing photo description
    @State private var photoTitle = ""  // State for storing photo description
    
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Spacer()
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    TextField("Enter a description...", text: $photoDescription)  // TextField for entering photo description
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Enter a title...", text: $photoDescription)  // TextField for entering photo description
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    
                } else {
                    LottieView(url: Bundle.main.url(forResource: "photo", withExtension: "lottie")!)
                }
                Spacer()
                VStack {
                    HStack {
                        if vm.image != nil {
                            Button(action: {
                                uploadImage(title: photoTitle, description: photoDescription, image: vm.image!) { result in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let response):
                                            print("Image uploaded successfully: \(response)")
                                            showRoomsSheet = true  // Trigger next view or action
                                        case .failure(let error):
                                            print("Upload failed with error: \(error)")
                                        }
                                    }
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .foregroundStyle(Color.homecare)
                                    Text("Enviar foto")
                                        .foregroundStyle(Color.white)
                                }
                                .frame(height: 60)
                                .padding()
                            }
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
                                ZStack {
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
                            }) {
                                ZStack {
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
                            }) {
                                ZStack {
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
            .navigationTitle("Analizar anuncio")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
                    .foregroundColor(.black)
            }

        }
        .background(Color.white)  // Sets the background color of the NavigationView to white
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    UploadPhotoView().environmentObject(ViewModel())
}
