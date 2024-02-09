//
//  analyzeImage.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 09/02/24.
//

import Foundation
import CoreML
import UIKit


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
        
        let top3Predictions = Array(output.targetProbability.sorted(by: { $0.value > $1.value }).prefix(3))
        
        // Print top 3 predictions for debugging purposes
        for (index, prediction) in top3Predictions.enumerated() {
            let label = prediction.key
            let percentage = Int(prediction.value * 100)
            print("\(index + 1). \(label): \(percentage)%")
        }
        
        // Call the uploadDiagnosticImage function
//        uploadDiagnosticImage(imageData: imageData, top3Predictions: top3Predictions) { result in
//            switch result {
//            case .success(let response):
//                print("Success: \(response)")
//
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
        
    } catch {
        print(error.localizedDescription)
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
