import SwiftUI
import RealityKit
import ARKit
import CoreML

@MainActor
class ARViewModel: NSObject, ObservableObject, ARSessionDelegate {
    
    @Published var currentIndex = 0
    @Published var capturedImage: UIImage?
    @Published var faceShapeResult: String = ""
    @Published var showResultPage = false
    @Published var hasAddedModel = false
    @Published var shouldDisplayModel = false

    let glassesModels = ["glasses3.usdz", "glasses2.usdz", "glasses1.usdz"]
    let glassesNames = ["Classic", "Round", "Sport"]

    var arView: ARView?
    var anchor: AnchorEntity?
    var currentModel: ModelEntity?
    var faceAnchorData: ARFaceAnchor?

    let modelRotations: [String: simd_quatf] = [
        "glasses3.usdz": simd_quatf(angle: 0, axis: [0, 1, 0]),
        "glasses2.usdz": simd_quatf(angle: 0, axis: [0, 1, 0]),
        "glasses1.usdz": simd_quatf(angle: 0, axis: [0, 1, 0])
    ]

    func nextGlasses() {
        currentIndex = (currentIndex + 1) % glassesModels.count
        reloadCurrentGlasses()
    }

    func previousGlasses() {
        currentIndex = (currentIndex - 1 + glassesModels.count) % glassesModels.count
        reloadCurrentGlasses()
    }

    func setupARView(for arView: ARView) {
        self.arView = arView
        arView.session.delegate = self

        let faceAnchorEntity = AnchorEntity(.face)
        arView.scene.anchors.append(faceAnchorEntity)
        self.anchor = faceAnchorEntity
        print("✅ Face anchor ditambahkan")

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        print("✅ ARView setup completed")
    }

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor else { continue }
            self.faceAnchorData = faceAnchor

            if let faceEntity = self.anchor {
                faceEntity.transform = Transform(matrix: faceAnchor.transform)
            }

            if let model = currentModel {
                updateGlassesTransform(for: faceAnchor, model: model)
            }

            if !hasAddedModel && shouldDisplayModel {
                loadGlassesModel(named: glassesModels[currentIndex])
                hasAddedModel = true
            }
        }
    }

    func loadGlassesModel(named name: String) {
        currentModel?.removeFromParent()

        guard let anchor = anchor else {
            print("⚠️ Anchor belum siap")
            return
        }

        do {
            let model = try ModelEntity.loadModel(named: name)
            print("✅ Berhasil load model: \(name)")

            model.position = [0, 0, 0]
            model.orientation = modelRotations[name] ?? simd_quatf(angle: 0, axis: [0, 1, 0])

            anchor.addChild(model)
            self.currentModel = model
            print("✅ Model ditambahkan ke anchor")
        } catch {
            print("❌ Gagal load model \(name): \(error.localizedDescription)")
        }
    }

    func updateGlassesTransform(for faceAnchor: ARFaceAnchor, model: ModelEntity) {
        let leftEyePos = faceAnchor.leftEyeTransform.columns.3
        let rightEyePos = faceAnchor.rightEyeTransform.columns.3
        let midEye = (leftEyePos + rightEyePos) / 2

        let verticalOffset: Float = 0.02
        let glassesPosition = SIMD3<Float>(midEye.x, midEye.y + verticalOffset, midEye.z)

        model.position = glassesPosition
        print("📍 Model position updated to \(glassesPosition)")

        model.orientation = simd_quatf(faceAnchor.transform)
        print("🔄 Model rotation updated to follow face orientation")

        let eyeDistance = simd_distance(leftEyePos, rightEyePos)
        let defaultEyeDistance: Float = 0.06
        let baseScale: Float = 0.001
        let scaleRatio = eyeDistance / defaultEyeDistance
        let scaleFactor = max(baseScale * scaleRatio, 0.001)

        model.setScale(SIMD3<Float>(repeating: scaleFactor), relativeTo: nil)
        print("📐 Skala model diperbarui: \(scaleFactor)")
    }

    func reloadCurrentGlasses() {
        guard hasAddedModel else { return }
        loadGlassesModel(named: glassesModels[currentIndex])
    }

    func classifyFaceShape() {
        guard let arView = arView else { return }

        arView.snapshot(saveToHDR: false) { image in
            guard let uiImage = image,
                  let pixelBuffer = uiImage.toCVPixelBuffer(),
                  let model = try? FaceShape(configuration: MLModelConfiguration()),
                  let prediction = try? model.prediction(image: pixelBuffer) else {
                print("❌ Gagal klasifikasi wajah")
                return
            }

            DispatchQueue.main.async {
                self.capturedImage = uiImage
                self.faceShapeResult = prediction.target
                self.showResultPage = true
                // Jangan load model di sini
            }
        }
    }
}
