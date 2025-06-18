import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var arViewModel: ARViewModel

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arViewModel.setupARView(for: arView)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Optional: bisa untuk update glasses jika butuh refresh saat pindah view
    }
}
