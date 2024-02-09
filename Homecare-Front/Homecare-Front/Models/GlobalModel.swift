//
//  GlobalModel.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 09/02/24.
//

import Foundation

class GlobalDataModel: ObservableObject {
    static let shared = GlobalDataModel()
    @Published var user: User?
    @Published var userRelations: [User] = []
    @Published var userImages: [ImageData] = [] // Add this line to define userImages
    @Published var medicalHistory: [MedicalHistoryItem] = []
    @Published var userProfileImageUrl: String? // New variable for profile image URL

    


    
    
    private init() {} // Private initializer to enforce singleton usage
}
