//
//  GlobalModel.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 09/02/24.
//

import Foundation
import Alamofire

class GlobalDataModel: ObservableObject {
    static let shared = GlobalDataModel()
    @Published var predictionData: [Double] = []
    @Published var advicePrompt: String = ""
    
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
