import SwiftUI
import RealityKit
import Combine
import SceneKit

struct ListView: View {
    @EnvironmentObject var arViewModel: ARViewModel
    @State private var selectedCategory: String = "All"
    @State private var showFavoritesOnly: Bool = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - Unique Categories for Filtering
    var sortedCategories: [String] {
        let allCategories = allGlassesGroups.map { $0.category }
        return ["All"] + Array(Set(allCategories)).sorted()
    }

    // MARK: - Filtered Groups Based on Selected Category
    var filteredGroups: [GlassesGroup] {
        if selectedCategory == "All" {
            return allGlassesGroups
        } else {
            return allGlassesGroups.filter { $0.category == selectedCategory }
        }
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredGroups, id: \.name) { group in
                        if let variant = group.variants.first {
                            let isFavorite = arViewModel.isFavorite(variant.modelFile)

                            GlassesCardView(
                                modelName: variant.modelFile,
                                groupName: group.name,
                                isFavorite: isFavorite,
                                tryOnAction: {
                                    if let groupIndex = allGlassesGroups.firstIndex(where: { $0.name == group.name }),
                                       let variantIndex = group.variants.firstIndex(where: { $0.modelFile == variant.modelFile }) {
                                        arViewModel.currentRecommendation = GlassesRecommendation(
                                            faceShape: "All",
                                            groups: allGlassesGroups,
                                            description: ""
                                        )
                                        arViewModel.currentGroupIndex = groupIndex
                                        arViewModel.currentVariantIndex = variantIndex
                                    }
                                },
                                toggleFavorite: {
                                    arViewModel.toggleFavorite(variant.modelFile)
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Collections")
            .onAppear {
                arViewModel.loadAllGlasses()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(sortedCategories, id: \.self) { category in
                            Button(category, action: { selectedCategory = category })
                        }
                    } label: {
                        Label("Category", systemImage: "list.bullet.circle")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showFavoritesOnly.toggle()
                    }) {
                        Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
            }
            
            .background(
                backgroundGradient()
                    .ignoresSafeArea()
            )
        }
        
    }
    
}

struct GlassesCardView: View {
    let modelName: String
    let groupName: String
    let isFavorite: Bool
    let tryOnAction: () -> Void
    let toggleFavorite: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Text(groupName)
                .font(.headline)
                .foregroundColor(.primary)
            
            // Bulat-bulat warna
            HStack(spacing: 6) {
                if let group = allGlassesGroups.first(where: { $0.name == groupName }) {
                    ForEach(group.variants, id: \.modelFile) { variant in
                        Circle()
                            .fill(Color(hex: variant.color))
                            .frame(width: 12, height: 12)
                            .overlay(Circle().stroke(Color.black.opacity(0.3), lineWidth: 0.5))
                    }
                }
            }
            Glases3DView(modelName: modelName)
                .frame(height: 100)
                .background(Color.clear)
                .cornerRadius(12)
                .shadow(radius: 4)

           

            HStack(spacing: 12) {
                NavigationLink(
                    destination: TryGlassesView(result: modelName, isSingleMode: true)
                        .onAppear(perform: tryOnAction)
                ) {
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

                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
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


#Preview {
    ListView()
        .environmentObject(ARViewModel())
}
