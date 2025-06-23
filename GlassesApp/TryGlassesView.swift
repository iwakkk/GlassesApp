import SwiftUI
import RealityKit
import ARKit

struct TryGlassesView: View {
    @EnvironmentObject var arViewModel: ARViewModel
    
    var result: String
    
    var recommendation: GlassesRecommendation {
        getRecommendation(for: result)
    }
    
    var isSingleMode: Bool = false
    
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
                            
                            Spacer ()
                            HStack(spacing: 12) {
                                ForEach(Array(group.variants.enumerated()), id: \.offset) { index, variant in
                                    let isSelected = index == arViewModel.currentVariantIndex
                                    let color = Color(hex: variant.color)
                                    
                                    VStack(spacing: 4) {
                                        Button(action: {
                                            arViewModel.currentGroupIndex = currentGroupIndex
                                            arViewModel.currentVariantIndex = index
                                            arViewModel.reloadCurrentGlasses()
                                            
                                            print("GroupIndex: \(arViewModel.currentGroupIndex)")
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
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                            .frame(maxWidth: 35)
                                    }
                                }
                               
                            }
                            .padding(15)
                            
                            Spacer()
                        }
                    }
                    
                    if !isSingleMode{
                        HStack {
                            
                            Button(action: {
                                arViewModel.previousGroup()
                            }) {
                                Image(systemName: "chevron.left.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                
                            }
                            
                            Spacer()
                            
                            //                        Text("Try: \(recommendation.glassesName[arViewModel.currentIndex])")
                            Text("Try: \(currentGroup?.name ?? "-")")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            Spacer()
                            
                            Button(action: {
                                arViewModel.nextGroup()
                            }) {
                                Image(systemName: "chevron.right.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    else{
                        Text("Try: \(currentGroup?.name ?? "-")")
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(20)
                    }
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            arViewModel.shouldDisplayModel = true
            arViewModel.hasAddedModel = false
            
            if let arView = arViewModel.arView {
                let config = ARFaceTrackingConfiguration()
                config.isLightEstimationEnabled = true
                arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                arViewModel.reloadCurrentGlasses()
                arViewModel.hasAddedModel = true
            }
        }
        .onDisappear {
            arViewModel.shouldDisplayModel = false
        }
        
    }
    
    var currentGroup: GlassesGroup? {
        guard recommendation.groups.indices.contains(currentGroupIndex) else { return nil }
        return recommendation.groups[currentGroupIndex]
    }
    
    var currentGroupIndex: Int {
        arViewModel.currentGroupIndex
    }
    
}
    

// menghitung index awal suatu grup di dalam array glassesModels (file usdz) karena disimpan di dalam 1 line
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


#Preview {
    TryGlassesView(result: "Oval")
        .environmentObject(ARViewModel())
}
