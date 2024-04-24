import SwiftUI
import RealityKit
import ARKit
import Combine

struct ARExperienceView: View {
    var image: UIImage
    
    var body: some View {
        ARViewContainer(selectedImage: image)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
    var selectedImage: UIImage?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.vertical] // Only vertical planes
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])

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

            context.coordinator.setupGestures(arView: arView, entity: planeEntity)

            print("Plane entity added to the scene.")
        } else {
            print("No image is selected or image is not valid.")
        }
        
        return arView
    }
    func makeCoordinator() -> Coordinator {
          Coordinator()
      }

      class Coordinator: NSObject {
          var entity: Entity?
          var arView: ARView?

          func setupGestures(arView: ARView, entity: Entity) {
              self.arView = arView
              self.entity = entity

              let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
              let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
              
              arView.addGestureRecognizer(pinchGesture)
              arView.addGestureRecognizer(panGesture)
          }
          
          @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
              guard let entity = entity else { return }
              
              if gesture.state == .changed {
                  let scale = Float(gesture.scale)
                  entity.scale *= SIMD3<Float>(repeating: scale)
                  gesture.scale = 1 // Reset scale factor to cumulative
              }
          }
          
          @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
              guard let arView = arView, let entity = entity else { return }
              
              let translation = gesture.translation(in: arView)
              if gesture.state == .changed {
                  let currentPosition = entity.position(relativeTo: nil)
                  let newPosition = SIMD3<Float>(currentPosition.x + Float(translation.x) * 0.001, currentPosition.y, currentPosition.z - Float(translation.y) * 0.001)
                  entity.setPosition(newPosition, relativeTo: nil)
                  gesture.setTranslation(.zero, in: arView) // Reset translation
              }
          }
      }
  }

