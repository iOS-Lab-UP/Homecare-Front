//
//  analyzeImage.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 09/02/24.
//

import Foundation
import CoreML
import UIKit
import Alamofire



func analyzeImage(image: UIImage) {

    
    guard let resizedImage = image.resize(to: CGSize(width: 224, height: 224)),
          let buffer = resizedImage.toCVPixelBuffer() else {
        print("Failed to prepare image for analysis.")
        return
    }
    
    // Convert UIImage to Data
    guard let imageData = resizedImage.jpegData(compressionQuality: 0.7) else { // or use resizedImage.pngData() if PNG format is needed
        print("Failed to convert image to data.")
        return
    }
    
    do {
        let config = MLModelConfiguration()
        let model = try ElectroDomesticCV(configuration: config)
        let input = ElectroDomesticCVInput(image: buffer)
        
        let output = try model.prediction(input: input)
        
        let top3Predictions = Array(output.targetProbability.sorted(by: { $0.value > $1.value }).prefix(4))
        
        // Print top 3 predictions for debugging purposes
        for (index, prediction) in top3Predictions.enumerated() {
            let label = prediction.key
            let percentage = Int(prediction.value * 100)
            print("\(index + 1). \(label): \(percentage)%")
        }
        
        // Call the predict function grab the biggest value
        let topElectrodomestic = top3Predictions[0].key
        
        let electrodomesticos: [String: Double] = [
            "Tele": (0.1 + 0.4) / 2,
            "microondas": (0.9 + 1.5) / 2,
            "Frigobar": (0.2 + 0.4) / 2,
            "Bombilla incandescente": (0.03 + 0.08) / 2,
            "Bombilla LED": (0.003 + 0.012) / 2
        ]
        
        let electrodomestic = electrodomesticos[topElectrodomestic] ?? 0.0
        
        predict(electrodomestic: electrodomestic) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    GlobalDataModel.shared.predictionData = data.map { Double($0) }
                    print("Prediction data: \(GlobalDataModel.shared.predictionData)")
                } else {
                    print("No data received")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }

        

        
    } catch {
        print(error.localizedDescription)
    }
}

func predict(electrodomestic: Double, completion: @escaping (Result<APIResponse<[Float]>, Error>) -> Void) {
    let parameters: [String: Any] = [
        "kwh": electrodomestic,
    ]
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    AF.request(APIEndpoints.predict, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
        switch response.result {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(APIResponse<[Float]>.self, from: data!)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}




extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(self.size.width),
                                         Int(self.size.height),
                                         kCVPixelFormatType_32ARGB,
                                         attrs,
                                         &pixelBuffer)
        guard status == kCVReturnSuccess else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            return nil
        }
        
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}
