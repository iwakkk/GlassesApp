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

    let glassesModels = ["glasses3.usdz", "glasses2.usdz", "glasses1.usdz"]
    let glassesNames = ["Classic", "Round", "Sport"]

    var arView: ARView?
    var anchor: AnchorEntity?
    var currentModel: ModelEntity?
    var faceAnchorData: ARFaceAnchor?

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

        // Tambahkan anchor sebelum session dijalankan
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

            // Log posisi untuk debugging
            let headPosition = faceAnchor.transform.columns.3
            print("🧠 Head position updated: x:\(headPosition.x), y:\(headPosition.y), z:\(headPosition.z)")

            updateGlassesScale()

            if !hasAddedModel {
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

            // Tambahkan sebagai anak dari anchor wajah (tidak perlu posisi aneh-aneh dulu)
            model.position = [0, 0.02, 0.05] // ini masih boleh, asal sesuai wajah

            // Skala disesuaikan dengan wajah nanti di updateGlassesScale()
            model.orientation = simd_quatf(angle: 0, axis: [0,1,0])
            anchor.addChild(model)

            self.currentModel = model
            print("✅ Model ditambahkan ke anchor")
            updateGlassesScale()
        } catch {
            print("❌ Gagal load model \(name): \(error.localizedDescription)")
        }
    }


    func updateGlassesScale() {
        guard let face = faceAnchorData, let model = currentModel else { return }

        let leftEye = face.leftEyeTransform.columns.3
        let rightEye = face.rightEyeTransform.columns.3
        let distance = simd_distance(leftEye, rightEye)
        print("👁 Jarak mata: \(distance)")

        let defaultEyeDistance: Float = 0.06
        let scaleRatio = distance / defaultEyeDistance
        let baseScale: Float = 0.001
        let scaleFactor = max(baseScale * scaleRatio, 0.001)

        model.setScale(SIMD3<Float>(repeating: scaleFactor), relativeTo: nil)
        print("📐 Skala disesuaikan: \(scaleFactor)")
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
            }
        }
    }
}
