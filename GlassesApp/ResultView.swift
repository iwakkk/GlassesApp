import SwiftUI

struct ResultView: View {
    var image: UIImage?
    var result: String

    @EnvironmentObject var arViewModel: ARViewModel

    @State private var selectedCategory: String = "All"
    
    let color = Color(hex: "#786CF3")

    var recommendation: GlassesRecommendation {
        getRecommendation(for: result)
    }

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var uniqueCategories: [String] {
        let categories = recommendation.groups.map { $0.category }
        return ["All"] + Array(Set(categories)).sorted()
    }

    var filteredGroups: [GlassesGroup] {
        if selectedCategory == "All" {
            return recommendation.groups
        } else {
            return recommendation.groups.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Face Shape Result:")
                    .font(.headline)

                Text(recommendation.faceShape)
                    .font(.title)
                    .bold()

                if let img = image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                }

                Text(recommendation.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Divider()

                Text("Recommended Glasses")
                    .font(.title3.bold())

                // Category Buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(uniqueCategories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category)
                                    .font(.subheadline)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(selectedCategory == category ? Color(color) : Color.white)
                                    .foregroundColor(selectedCategory == category ? Color.white : .primary)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(filteredGroups, id: \.name) { group in
                        if let firstVariant = group.variants.first {
                            VStack(spacing: 8) {
                                Image(group.name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 70)
                                    .cornerRadius(10)

                                HStack(spacing: 6) {
                                    ForEach(group.variants, id: \.modelFile) { variant in
                                        Circle()
                                            .fill(Color(hex: variant.color))
                                            .frame(width: 12, height: 12)
                                            .overlay(Circle().stroke(Color.black.opacity(0.3), lineWidth: 0.5))
                                    }
                                }

                                Text(group.name)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 2)
                            }
                            .padding()
                            .frame(width: 120, height: 150)
                            .background(Color.white)
                            .cornerRadius(16)
                        }
                    }
                }

                NavigationLink(destination: TryGlassesView(result: result).environmentObject(arViewModel)) {
                    Text("👓 Try Glasses")
                        .font(.headline)
                        .padding()
                        .background(Color(color))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding(.top, 20)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(
            backgroundGradient()
                .ignoresSafeArea()
        )
    }
}

func backgroundGradient() -> LinearGradient {
    return LinearGradient(
        gradient: Gradient(colors: [
            Color("backcolor"), Color.gray.opacity(0.1)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
}


#Preview {
    let dummyImage = UIImage(systemName: "person.circle")
    let dummyResult = "Oval"

    return NavigationView {
        ResultView(image: dummyImage, result: dummyResult)
            .environmentObject(ARViewModel())
    }
}
