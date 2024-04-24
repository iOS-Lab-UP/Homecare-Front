import SwiftUI
import RealityKit
import ARKit
import Combine

struct ARExperienceView: View {
    var image: UIImage
    
    var body: some View {
        ARViewContainer()
    }
}
struct ARViewContainer: UIViewRepresentable {
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    var selectedImages: [UIImage] = GlobalDataModel.shared.asvertisments

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Initial position for the first entity
            var initialPosition = SIMD3<Float>(0, 0, -0.5) // Start half a meter in front of the camera
            let positionOffset = SIMD3<Float>(0.5, 0, 0) // Half a meter apart on the x-axis

            for image in selectedImages {
                if let entity = createEntity(from: image) {
                    let anchorEntity = AnchorEntity(plane: .vertical)
                    entity.position = initialPosition
                    anchorEntity.addChild(entity)
                    arView.scene.addAnchor(anchorEntity)
                    
                    context.coordinator.setupGestures(arView: arView, entity: entity)
                    
                    // Update initialPosition for the next entity
                    initialPosition += positionOffset
                }
            }

        print("Entities added to the scene.")
        return arView
    }
    
    func createEntity(from image: UIImage) -> ModelEntity? {
            guard let cgImage = image.cgImage else {
                print("Image is not valid.")
                return nil
            }

            let options = TextureResource.CreateOptions(semantic: .color)
            guard let texture = try? TextureResource.generate(from: cgImage, options: options) else {
                print("Failed to generate texture")
                return nil
            }

            var material = SimpleMaterial()
            material.baseColor = MaterialColorParameter.texture(texture)
            material.metallic = MaterialScalarParameter(floatLiteral: 0.0)
            material.roughness = MaterialScalarParameter(floatLiteral: 1.0)

            let planeMesh = MeshResource.generatePlane(width: 0.4, depth: 0.3)
            return ModelEntity(mesh: planeMesh, materials: [material])
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
