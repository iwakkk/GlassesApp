import SwiftUI
import SceneKit


struct Glases3DView: UIViewRepresentable {
    let modelName: String
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        
        sceneView.scene = SCNScene()
        
        sceneView.autoenablesDefaultLighting = true
        
        
        //ganti true bila ingin digerakkan
        sceneView.allowsCameraControl = false
        
        sceneView.backgroundColor = .clear
        if let url = Bundle.main.url(forResource: modelName, withExtension: nil),
           let scene = try? SCNScene(url: url, options: nil) {
            
            let rootNode = SCNNode()
            
            for child in scene.rootNode.childNodes {
                rootNode.addChildNode(child)}
            // Add all child nodes from the loaded scene into the root node
            
            
            // Add the custom root node into the main scene’s root
            sceneView.scene?.rootNode.addChildNode(rootNode)
        } else {
            print("Failed to load usdz")
        } // Error message if model is not found or fails to load
        
        return sceneView
    }
    func updateUIView(_ uiView: SCNView, context: Context) {
        // No dynamic updates needed for static model view
    }
}


