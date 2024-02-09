//
//  MainHomecareApp.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import CoreML
import SwiftUI
import AVFoundation


struct MainView: View {
    @State private var selectedTab = 1
    var body: some View {
        VStack {
            switch selectedTab {
            case 1:
                HomeView()
            case 2:
                EnergyConsumptionDashboardView()
            case 3:

                UploadPhotoView()
                    .environmentObject(ViewModel())
                    
            case 4:
                RoomListView()

            case 5:
                SettingsView()

            default:
                HomeView()
            }
            
            
            ToolBar(selectedTab: $selectedTab)
        }
        .padding(.bottom, 20)
        .background(Color.white)
    }
}

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    
    func showPhotoPicker() {
        if source == .camera {
            Picker.checkCameraPermissions { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.showPicker = true
                    } else {
                        // Consider using a published property or a state variable to trigger an alert view here.
                        print("Acceso a la cámara denegado o restringido")
                        // Show an alert to the user with instructions to enable camera access.
                    }
                }
            }
        } else {
            // No permission needed for the photo library, but consider checking for PHPhotoLibrary permissions.
            showPicker = true
        }
    }

}


@main
struct MainHomecareApp: App {
    var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}

#Preview{
    MainView()
}



