import SwiftUI
import RealityKit
import Combine
import SceneKit

struct ListView: View {
    @EnvironmentObject var arViewModel: ARViewModel
    @State private var showTryGlassesView = false
    @State private var selectedFilter: String = "All"
    @State private var showFavoritesOnly: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var filteredItems: [(offset: Int, element: String)] {
        arViewModel.glassesModels.enumerated().filter { index, model in
            let name = arViewModel.glassesNames[index]
            let matchesFilter = (selectedFilter == "All" || name == selectedFilter)
            let isFavorite = arViewModel.isFavorite(model)
            return matchesFilter && (!showFavoritesOnly || isFavorite)
        }
    }

    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredItems, id: \.offset) { index, modelName in
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
                                
                                NavigationLink(
                                    destination: TryGlassesView(isSingleMode: true)
                                        .environmentObject(arViewModel)
                                        .onAppear {
                                            arViewModel.currentIndex = index
                                        }
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
                                
                                
                                // Favorite button
                                Button(action: {
                                    arViewModel.toggleFavorite(modelName)
                                }) {
                                    Image(systemName: arViewModel.isFavorite(modelName) ? "heart.fill" : "heart")
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
            .navigationTitle("Collections")
            
            .toolbar {
                // FILTER MODELS
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button("All", action: { selectedFilter = "All" })
                        ForEach(Array(Set(arViewModel.glassesNames)).sorted(), id: \.self) { name in
                            Button(name, action: { selectedFilter = name })
                        }
                    } label: {
                        Label("Models", systemImage: "list.bullet.circle")
                    }
                }

                // TOGGLE FAVORITES
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showFavoritesOnly.toggle()
                    }) {
                        Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    ListView()
        .environmentObject(ARViewModel())
}
