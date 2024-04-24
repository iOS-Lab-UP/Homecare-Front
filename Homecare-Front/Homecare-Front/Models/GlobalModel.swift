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


struct UploadResponse: Codable {
    let success: Bool
    let image: String?
}


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

func decodeBase64ToImage(base64String: String) -> UIImage? {
    // Sometimes, the Base64 string may come prefixed with a data URI scheme that needs to be removed.
    let base64StringProcessed = base64String
        .replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
        .replacingOccurrences(of: "data:image/png;base64,", with: "")

    if let imageData = Data(base64Encoded: base64StringProcessed, options: .ignoreUnknownCharacters) {
        return UIImage(data: imageData)
    } else {
        return nil
    }
}



func uploadImage(title: String, description: String, image: UIImage, completion: @escaping (Result<Any, AFError>) -> Void) {
    let base64Image = convertImageToBase64String(img: image)

    let parameters: [String: Any] = [
        "title": title,
        "description": description,
        "image": base64Image
    ]

    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]

    AF.request(APIEndpoints.uploadImage, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
        switch response.result {
        case .success(let data):
            do {
                if let jsonData = data {
                    let uploadResponse = try JSONDecoder().decode(UploadResponse.self, from: jsonData)
                    print("Success with JSON: \(uploadResponse)")
                    if let base64Image = uploadResponse.image {
                        DispatchQueue.main.async {
                            if let decodedImage = decodeBase64ToImage(base64String: base64Image) {
                                GlobalDataModel.shared.advertisement = decodedImage
                                print(GlobalDataModel.shared.advertisement)
                                completion(.success(decodedImage))
                            } else {
                                print("Failed to decode image.")
                                completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                            }
                        }
                    } else {
                        print("No image data found in response.")
                        completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                    }
                } else {
                    throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                }
            } catch let error {
                print("Decoding failure: \(error)")
                completion(.failure(AFError.responseSerializationFailed(reason: .decodingFailed(error: error))))
            }
        case .failure(let error):
            print("Network request failure: \(error)")
            completion(.failure(error))
        }
    }



}

