import SwiftUI
import Vision

extension UIImage {
    func cropped(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage?.cropping(to: rect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

struct CFEOCRView: View {
    @State private var recognizedTotal: String = ""
    @State private var recognizedPeriod: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Total a Pagar: \(recognizedTotal)")
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Text("Periodo Facturado: \(recognizedPeriod)")
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button("Recognize Text") {
                if let image = UIImage(named: "recibo_completo") {
                    // Definir el área de recorte para el total a pagar
                    let totalRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height * 0.1) // Ajusta estos valores
                    if let croppedTotal = image.cropped(to: totalRect) {
                        recognizeText(in: croppedTotal) { recognizedString in
                            self.recognizedTotal = recognizedString
                        }
                    }
                    
                    // Definir el área de recorte para el periodo facturado
                    let periodRect = CGRect(x: 0, y: image.size.height * 0.5, width: image.size.width, height: image.size.height * 0.1) // Ajusta estos valores
                    if let croppedPeriod = image.cropped(to: periodRect) {
                        recognizeText(in: croppedPeriod) { recognizedString in
                            self.recognizedPeriod = recognizedString
                        }
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    func recognizeText(in image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else {
            print("Error while converting")
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest { (request, error) in
            if let error = error {
                print("Error while recognizing: \(error.localizedDescription)")
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("Couldn't get recognized text")
                return
            }
            
            var detectedText = ""
            for observation in observations {
                if let topCandidate = observation.topCandidates(1).first {
                    detectedText += topCandidate.string + "\n"
                }
            }
            DispatchQueue.main.async {
                completion(detectedText.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
        request.recognitionLevel = .accurate
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error at request: \(error.localizedDescription)")
        }
    }
}

