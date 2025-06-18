import SwiftUI
import RealityKit
import ARKit

struct TryGlassesView: View {
    @EnvironmentObject var arViewModel: ARViewModel

    var body: some View {
        VStack {
            ZStack {
                ARViewContainer()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            arViewModel.previousGlasses()
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }

                        Spacer()

                        Text("Try: \(arViewModel.glassesNames[arViewModel.currentIndex])")
                            .foregroundColor(.white)
                            .font(.headline)

                        Spacer()

                        Button(action: {
                            arViewModel.nextGlasses()
                        }) {
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.5))
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            arViewModel.shouldDisplayModel = true
            arViewModel.hasAddedModel = false

            if let arView = arViewModel.arView {
                let config = ARFaceTrackingConfiguration()
                config.isLightEstimationEnabled = true
                arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
                print("🔁 ARSession restarted")
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                arViewModel.loadGlassesModel(named: arViewModel.glassesModels[arViewModel.currentIndex])
                arViewModel.hasAddedModel = true
            }
        }
        .onDisappear{
            arViewModel.shouldDisplayModel = false
            arViewModel.hasAddedModel = true
        }

    }
}
