//
//  GlobalModel.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 09/02/24.
//

import Foundation
import Alamofire
import SwiftUI
import UIKit



class GlobalDataModel: ObservableObject {
    static let shared = GlobalDataModel()
    @Published var predictionData: [Double] = []
    @Published var advicePrompt: String = ""
    // image
    @Published var selectedImage: UIImage?
    @Published var advertisement: UIImage?
    
    private init() {} // Private initializer to enforce singleton usage
    
    func updateAdvicePrompt(newPrompt: String) {
            self.advicePrompt = newPrompt
            self.objectWillChange.send()
        }
    
}

func fetchMotivationalPhrase() {
    
    AF.request(APIEndpoints.advicePrompt).responseDecodable(of:
            Phrase.self) { response in
            switch response.result {
            case .success(let motivationalPhrase):
                GlobalDataModel.shared.updateAdvicePrompt(newPrompt: motivationalPhrase.phrase)
                print("Advice Prompt: \(motivationalPhrase.phrase)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }    }



func convertImageToBase64String(img: UIImage) -> String {
    let imageData = img.jpegData(compressionQuality: 0.5)! // Adjust compression quality as needed
    return imageData.base64EncodedString(options: .lineLength64Characters)
}

func uploadIMage(title: String, description: String, image: UIImage) {
    let base64Image = convertImageToBase64String(img: image)
    
    // Constructing the parameters dictionary
    let parameters: [String: Any] = [
        "title": title,
        "description": description,
        "image": base64Image
    ]
    
    // Sending request with Alamofire
    AF.request(APIEndpoints.uploadImage, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        switch response.result {
        case .success(let value):
            print("Success: \(value)")
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
