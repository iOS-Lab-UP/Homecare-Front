//
//  GlobalModel.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 09/02/24.
//

import Foundation

class GlobalDataModel: ObservableObject {
    static let shared = GlobalDataModel()
    @Published var predictionData: [Double] = []
    @Published var advicePrompt: String = ""
    

    private init() {} // Private initializer to enforce singleton usage
}
