import SwiftUI
import RealityKit
import ARKit
import CoreML

@MainActor
class ARViewModel: NSObject, ObservableObject, ARSessionDelegate {

    @Published var currentGroupIndex: Int = 0 {
        didSet {
            currentVariantIndex = 0
            if hasAddedModel {
                reloadCurrentGlasses()
            }
        }
    }
    
    @Published var currentVariantIndex: Int = 0 {
        didSet {
            if hasAddedModel {
                reloadCurrentGlasses()
            }
        }
    }
    
    

    @Published var capturedImage: UIImage?
    @Published var faceShapeResult: String = ""
    @Published var showResultPage = false
    @Published var hasAddedModel = false
    @Published var shouldDisplayModel = false
    @Published var favorites: Set<String> = []
    @Published var glassesModels: [String] = []
    @Published var currentRecommendation: GlassesRecommendation? = nil
    @Published var modelToGroupName: [String: String] = [:]

    var arView: ARView?
    var anchor: AnchorEntity?
    var currentModel: ModelEntity?
    var faceAnchorData: ARFaceAnchor?
    var result: String = ""

    func loadAllGlasses() {
        var result: [String] = []
        var mapping: [String: String] = [:]

        for group in allGlassesGroups {
            if let firstVariant = group.variants.first {
                result.append(firstVariant.modelFile)
                mapping[firstVariant.modelFile] = group.name
            }
        }

        self.glassesModels = result
        self.modelToGroupName = mapping
    }

    
    var recommendation: GlassesRecommendation {
        getRecommendation(for: result)
    }

    var currentGroup: GlassesGroup? {
        guard recommendation.groups.indices.contains(currentGroupIndex) else { return nil }
        return recommendation.groups[currentGroupIndex]
    }

    func updateGlassesFromRecommendation() {
        let recommendation = getRecommendation(for: faceShapeResult)
        self.currentRecommendation = recommendation
        self.currentGroupIndex = 0
        self.currentVariantIndex = 0

        var mapping: [String: String] = [:]
        let allModels = recommendation.groups.flatMap { group in
            group.variants.map { variant in
                mapping[variant.modelFile] = group.name
                return variant.modelFile
            }
        }
        self.glassesModels = allModels
        self.modelToGroupName = mapping
        self.hasAddedModel = false
        print("\u{1F576}\u{FE0F} Loaded models for face shape: \(faceShapeResult)")
    }

    func toggleFavorite(_ modelName: String) {
        if favorites.contains(modelName) {
            favorites.remove(modelName)
        } else {
            favorites.insert(modelName)
        }
    }

    func isFavorite(_ modelName: String) -> Bool {
        favorites.contains(modelName)
    }

    func nextGroup() {
        guard let recommendation = currentRecommendation else { return }
        if currentGroupIndex < recommendation.groups.count - 1 {
            currentGroupIndex += 1
        }
    }

    func previousGroup() {
        if currentGroupIndex > 0 {
            currentGroupIndex -= 1
        }
    }

    func selectVariant(index: Int) {
        currentVariantIndex = index
    }

    func setupARView(for arView: ARView) {
        self.arView = arView
        arView.session.delegate = self

        let faceAnchorEntity = AnchorEntity(.face)
        arView.scene.anchors.append(faceAnchorEntity)
        self.anchor = faceAnchorEntity
        print("✅ Face anchor added")

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true

        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        print("✅ ARView setup completed")
    }

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor else { continue }
            self.faceAnchorData = faceAnchor
            updateGlassesScale()

            if !hasAddedModel && shouldDisplayModel {
                if let modelName = currentModelFile() {
                    loadGlassesModel(named: modelName)
                    hasAddedModel = true
                }
            } else if !shouldDisplayModel, hasAddedModel {
                removeGlassesModel()
            }
        }
    }

    func removeGlassesModel() {
        guard let model = currentModel else {
            print("⚠️ No model to remove")
            return
        }

        model.removeFromParent()
        currentModel = nil
        hasAddedModel = false
        print("🗑 Model removed successfully")
    }

    func loadGlassesModel(named name: String) {
        currentModel?.removeFromParent()

        guard let anchor = anchor else {
            print("⚠️ Anchor not ready")
            return
        }

        do {
            let model = try ModelEntity.loadModel(named: name)
            print("✅ Successfully loaded model: \(name)")

            model.position = [0, 0.02, 0.05]
            model.orientation = simd_quatf(angle: 0, axis: [0,1,0])
            anchor.addChild(model)

            self.currentModel = model
            print("✅ Model added to anchor")

            updateGlassesScale()
        } catch {
            print("❌ Failed to load model \(name): \(error.localizedDescription)")
        }
    }

    func updateGlassesScale() {
        guard let face = faceAnchorData, let model = currentModel else { return }

        let leftEye = face.leftEyeTransform.columns.3
        let rightEye = face.rightEyeTransform.columns.3
        let distance = simd_distance(leftEye, rightEye)

        let defaultEyeDistance: Float = 0.06
        let scaleRatio = distance / defaultEyeDistance
        let baseScale: Float = 0.001
        let scaleFactor = max(baseScale * scaleRatio, 0.001)

        model.setScale(SIMD3<Float>(repeating: scaleFactor), relativeTo: nil)
    }

    func reloadCurrentGlasses() {
        guard hasAddedModel else { return }
        if let modelName = currentModelFile() {
            loadGlassesModel(named: modelName)
        }
    }

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

            DispatchQueue.main.async {
                self.capturedImage = uiImage
                self.faceShapeResult = prediction.target
                self.updateGlassesFromRecommendation()
                self.showResultPage = true
            }
        }
    }

    func currentGroupAndVariant() -> (group: GlassesGroup, variant: GlassesVariant)? {
        guard let recommendation = currentRecommendation else { return nil }
        guard recommendation.groups.indices.contains(currentGroupIndex) else { return nil }
        let group = recommendation.groups[currentGroupIndex]
        guard group.variants.indices.contains(currentVariantIndex) else { return nil }
        return (group, group.variants[currentVariantIndex])
    }

    func currentModelFile() -> String? {
        guard let recommendation = currentRecommendation else { return nil }
        guard recommendation.groups.indices.contains(currentGroupIndex) else { return nil }
        let group = recommendation.groups[currentGroupIndex]
        guard group.variants.indices.contains(currentVariantIndex) else { return nil }
        return group.variants[currentVariantIndex].modelFile
    }
}
