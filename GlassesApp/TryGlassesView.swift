import SwiftUI
import RealityKit
import ARKit

struct TryGlassesView: View {
    @EnvironmentObject var arViewModel: ARViewModel
    var result: String
    
    var recommendation: GlassesRecommendation {
        getRecommendation(for: result)
    }

    var body: some View {
        VStack {
            ZStack {
                ARViewContainer()
                    .environmentObject(arViewModel)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    
                    HStack {
                        
                        if let group = currentGroup {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(Array(group.variants.enumerated()), id: \.offset) { index, variant in
                                        let isSelected = index == baseIndex
                                        let color = Color(hex: variant.color)
                                        
                                        VStack(spacing: 4) {
                                            Button(action: {
                                                arViewModel.currentIndex = getGroupBaseIndex(recommendation: recommendation, groupName: group.name) + index
                                                arViewModel.reloadCurrentGlasses()
                                            }) {
                                                Circle()
                                                    .fill(color)
                                                    .frame(width: 30, height: 30)
                                                    .overlay(
                                                        Circle()
                                                            .stroke(Color.white, lineWidth: isSelected ? 3 : 0)
                                                    )
                                            }
                                            Text(variant.displayName)
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    HStack {
                        Button(action: {
                            arViewModel.previousGlasses()
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        

//                        Text("Try: \(recommendation.glassesName[arViewModel.currentIndex])")
                        Text("Try: \(arViewModel.currentGroupAndVariant()?.group.name ?? "-")")
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
    var currentGroup: GlassesGroup? {
        let recommendation = getRecommendation(for: result)
        var index = 0
        for group in recommendation.groups {
            if index + group.variants.count > arViewModel.currentIndex {
                return group
            }
            index += group.variants.count
        }
        return nil
    }
    var baseIndex: Int {
        if let group = currentGroup {
            return arViewModel.currentIndex - getGroupBaseIndex(recommendation: recommendation, groupName: group.name)
        }
        return 0
    }

}

func getGroupBaseIndex(recommendation: GlassesRecommendation, groupName: String) -> Int {
    var base = 0
    for group in recommendation.groups {
        if group.name == groupName { break }
        base += group.variants.count
    }
    return base
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}



//#Preview {
//    TryGlassesView()
//        .environmentObject(ARViewModel())
//}

//#Preview {
//    TryGlassesView(result: "Oval")
//        .environmentObject(ARViewModel())
//}
