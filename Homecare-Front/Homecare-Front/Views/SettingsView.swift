//
//  SettingsView.swift
//  Homecare-Front
//
//  Created by Enrique Gómez Tagle on 08/02/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var previewIndex = 0
    @State private var username = "Enrique Gómez Tagle"
    @State private var selectedOption = "Option 1"
    @State private var volumeLevel = 50.0
    @State private var darkModeEnabled = false
    
    let previewOptions = ["Always", "When Unlocked", "Never"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("General").foregroundColor(.primary)) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.green)
                        TextField("Username", text: $username)
                    }
                }
                
                Section(header: Text("Notifications").foregroundColor(.primary)) {
                    Toggle(isOn: $notificationsEnabled) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.yellow)
                            Text("Enabled")
                        }
                    }
                    
                    Picker("Show Previews", selection: $previewIndex) {
                        ForEach(0..<previewOptions.count) {
                            Text(self.previewOptions[$0])
                        }
                    }
                }
                
                Section(header: Text("Sound").foregroundColor(.primary)) {
                    HStack {
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundColor(.blue)
                        Slider(value: $volumeLevel, in: 0...100, step: 1) {
                            Text("Volume")
                        }
                    }
                }
                
                Section(header: Text("Appearance").foregroundColor(.primary)) {
                    Toggle(isOn: $darkModeEnabled) {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.purple)
                            Text("Dark Mode")
                        }
                    }
                }
                
                Section {
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                            Text("Clear Data")
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}


#Preview{
    SettingsView()
}
