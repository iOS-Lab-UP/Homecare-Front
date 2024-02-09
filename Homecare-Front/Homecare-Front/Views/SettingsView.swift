//
//  SettingsView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 08/02/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = false
    @State private var previewIndex = 0
    @State private var username = ""
    @State private var selectedOption = "Option 1"
    
    let previewOptions = ["Always", "When Unlocked", "Never"]
    let options = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    TextField("Username", text: $username)
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Enabled", isOn: $notificationsEnabled)
                    
                    Picker("Show Previews", selection: $previewIndex) {
                        ForEach(0..<previewOptions.count) {
                            Text(self.previewOptions[$0])
                        }
                    }
                }
                
                Section(header: Text("More Options")) {
                    Picker("Select Option", selection: $selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

#Preview{
    SettingsView()
}
