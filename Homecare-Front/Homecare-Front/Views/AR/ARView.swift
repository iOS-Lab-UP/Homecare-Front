import SwiftUI
import RealityKit
import ARKit
import Combine

struct ARViewContainer: UIViewRepresentable {
    var selectedImage: UIImage?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.vertical] // Only vertical planes
        arView.session.run(config)
        
        if let uiImage = selectedImage, let cgImage = uiImage.cgImage {
            var material = SimpleMaterial(color: .white, isMetallic: false)
            do {
                // Use empty options if not setting anything specific
                let options = TextureResource.CreateOptions(semantic: .color)
                let texture = try TextureResource.generate(from: cgImage, options: options)
                material.baseColor = MaterialColorParameter.texture(texture)
                print("Texture created successfully.")
            } catch {
                print("Failed to generate texture: \(error.localizedDescription)")
                return arView
            }

            let planeMesh = MeshResource.generatePlane(width: 0.4, depth: 0.3)
            let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
            
            // Since we're working with vertical planes, the plane entity should be oriented correctly by default
            // If not, adjust the orientation here
            
            let anchorEntity = AnchorEntity(plane: .vertical)
            anchorEntity.addChild(planeEntity)
            arView.scene.addAnchor(anchorEntity)
            print("Plane entity added to the scene.")
        } else {
            print("No image is selected or image is not valid.")
        }
        
        return arView
    }
    

    func updateUIView(_ uiView: ARView, context: Context) {}
    
    // Add a Coordinator to manage Scene subscriptions
    final class Coordinator {
        var subscriptions: Set<AnyCancellable> = []
        
        // Coordinator could also handle other interactions between the AR view and SwiftUI
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
