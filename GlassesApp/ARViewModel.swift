import SwiftUI
import RealityKit
import ARKit
import CoreML

@MainActor
class ARViewModel: NSObject, ObservableObject, ARSessionDelegate {
    // Observable state variables for UI binding
    @Published var currentIndex = 0                     // Current selected glasses index
    @Published var capturedImage: UIImage?              // Captured face image from ARView
    @Published var faceShapeResult: String = ""         // Result from CoreML face shape classification
    @Published var showResultPage = false               // Flag to toggle result screen
    @Published var hasAddedModel = false                // Flag to ensure model is added only once
    @Published var shouldDisplayModel = false           // Flag to control whether model should be shown

    // Array of model file names and corresponding display names
    let glassesModels = ["glasses3.usdz", "glasses2.usdz", "glasses1.usdz"]
    let glassesNames = ["Classic", "Round", "Sport"]

    // References for AR components
    var arView: ARView?                                 // The ARView displaying the scene
    var anchor: AnchorEntity?                           // Face anchor entity to attach models
    var currentModel: ModelEntity?                      // Currently loaded glasses model
    var faceAnchorData: ARFaceAnchor?                   // Live face tracking data from ARKit

    // Move to next glasses model
    func nextGlasses() {
        currentIndex = (currentIndex + 1) % glassesModels.count
        reloadCurrentGlasses()
    }

    // Move to previous glasses model
    func previousGlasses() {
        currentIndex = (currentIndex - 1 + glassesModels.count) % glassesModels.count
        reloadCurrentGlasses()
    }

    // Setup the ARView and start face tracking session
    func setupARView(for arView: ARView) {
        self.arView = arView
        arView.session.delegate = self

        // Add a face anchor entity to the scene before starting the session
        let faceAnchorEntity = AnchorEntity(.face)
        arView.scene.anchors.append(faceAnchorEntity)
        self.anchor = faceAnchorEntity
        print("✅ Face anchor added")

        // Configure AR session for face tracking
        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true

        // Run session with options to reset tracking and remove old anchors
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        print("✅ ARView setup completed")
    }

    // Called every time ARKit updates face tracking data
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor else { continue }
            self.faceAnchorData = faceAnchor

            // Debug: log head position for tracking
            let headPosition = faceAnchor.transform.columns.3
            print("🧠 Head position updated: x:\(headPosition.x), y:\(headPosition.y), z:\(headPosition.z)")

            // Adjust glasses scale based on eye distance
            updateGlassesScale()

            // Add model only once when flag is true
            if !hasAddedModel && shouldDisplayModel {
                loadGlassesModel(named: glassesModels[currentIndex])
                hasAddedModel = true
            }
        }
    }

    // Load and display a glasses model by name
    func loadGlassesModel(named name: String) {
        // Remove previous model if any
        currentModel?.removeFromParent()

        guard let anchor = anchor else {
            print("⚠️ Anchor not ready")
            return
        }

        do {
            // Load model from .usdz file
            let model = try ModelEntity.loadModel(named: name)
            print("✅ Successfully loaded model: \(name)")

            // Set position slightly in front of face for alignment
            model.position = [0, 0.02, 0.05]

            // Initial rotation (can be customized)
            model.orientation = simd_quatf(angle: 0, axis: [0,1,0])

            // Attach to face anchor
            anchor.addChild(model)

            self.currentModel = model
            print("✅ Model added to anchor")

            // Adjust size based on face data
            updateGlassesScale()
        } catch {
            print("❌ Failed to load model \(name): \(error.localizedDescription)")
        }
    }

    // Dynamically scale the model based on the user's face size (eye distance)
    func updateGlassesScale() {
        guard let face = faceAnchorData, let model = currentModel else { return }

        let leftEye = face.leftEyeTransform.columns.3
        let rightEye = face.rightEyeTransform.columns.3
        let distance = simd_distance(leftEye, rightEye)
        print("👁 Eye distance: \(distance)")

        // Normalize scale based on a default human eye distance (~6 cm)
        let defaultEyeDistance: Float = 0.06
        let scaleRatio = distance / defaultEyeDistance
        let baseScale: Float = 0.001
        let scaleFactor = max(baseScale * scaleRatio, 0.001)

        model.setScale(SIMD3<Float>(repeating: scaleFactor), relativeTo: nil)
        print("📐 Scale adjusted: \(scaleFactor)")
    }

    // Reload current model based on index (e.g., when switching glasses)
    func reloadCurrentGlasses() {
        guard hasAddedModel else { return }
        loadGlassesModel(named: glassesModels[currentIndex])
    }

    // Take a snapshot and run CoreML model to classify face shape
    func classifyFaceShape() {
        guard let arView = arView else { return }

        arView.snapshot(saveToHDR: false) { image in
            guard let uiImage = image,
                  let pixelBuffer = uiImage.toCVPixelBuffer(),
                  let model = try? FaceShape(configuration: MLModelConfiguration()),
                  let prediction = try? model.prediction(image: pixelBuffer) else {
                print("❌ Failed to classify face")
                return
            }

            // Update UI with prediction result
            DispatchQueue.main.async {
                self.capturedImage = uiImage
                self.faceShapeResult = prediction.target
                self.showResultPage = true
            }
        }
    }
}
