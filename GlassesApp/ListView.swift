
import SwiftUI
import RealityKit
import Combine
import SceneKit

struct ListView: View {
    @EnvironmentObject var arViewModel: ARViewModel

    @State private var showTryGlassesView = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            // Navigation trigger to TryGlassesView
            NavigationLink(
                destination: TryGlassesView(isSingleMode: true)
                    .environmentObject(arViewModel),
                isActive: $showTryGlassesView,
                label: { EmptyView() }
            )
            .hidden()

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Array(arViewModel.glassesModels.enumerated()), id: \.offset) { index, modelName in
                    VStack {
                        // Glasses name
                        Text(arViewModel.glassesNames[index])
                            .font(.headline)
                            .foregroundColor(.primary)

                        // Color indicator (3 black dots for now)
                        HStack {
                            Circle().fill(Color.black).frame(width: 10, height: 10)
                            Circle().fill(Color.black).frame(width: 10, height: 10)
                            Circle().fill(Color.black).frame(width: 10, height: 10)
                        }

                        // 3D Preview
                        Glases3DView(modelName: modelName)
                            .frame(height: 100)
                            .background(Color.clear)
                            .cornerRadius(12)
                            .shadow(radius: 4)

                        // Action buttons
                        HStack(spacing: 12) {
                            // Try On button
                            Button(action: {
                                arViewModel.currentIndex = index
                                showTryGlassesView = true
                            }) {
                                HStack {
                                    Image(systemName: "eyeglasses")
                                    Text("Try On")
                                        .fontWeight(.semibold)
                                }
                                .font(.caption)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            }

                            // Favorite button
                            Button(action: {
                                print("Added to Favorite: \(modelName)")
                            }) {
                                Image(systemName: "heart")
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(10)
                                    .background(Color.red.opacity(0.1))
                                    .foregroundColor(.red)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding()
                    .frame(width: 180)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Glasses List")

    }
}

#Preview {
    ListView()
        .environmentObject(ARViewModel())
}