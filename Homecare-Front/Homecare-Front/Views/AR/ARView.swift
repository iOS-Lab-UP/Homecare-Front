//
//  ARView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 23/04/24.
//




import SwiftUI
import RealityKit
import ARKit



struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Start an AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // or .horizontal for floor/tables
        arView.session.run(config)
        
        // Create a plane mesh and texture it with an image
        let imageName = "garden" // make sure this is in your asset catalog
        guard let image = UIImage(named: imageName) else {
            fatalError("Failed to load image asset.")
        }
        
        var material = SimpleMaterial(color: .white, isMetallic: false)
        material.baseColor = try! .texture(.load(named: imageName))
        
        let planeMesh = MeshResource.generatePlane(width: 0.4, depth: 0.3) // size can be adjusted
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        
        // Place the plane in the AR scene
        let anchorEntity = AnchorEntity(plane: .horizontal)
        anchorEntity.addChild(planeEntity)
        arView.scene.addAnchor(anchorEntity)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
