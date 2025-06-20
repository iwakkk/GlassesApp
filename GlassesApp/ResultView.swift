//  ResultView.swift
//  GlassesApp
//
//  Created by Felicia Stevany Lewa on 16/06/25.
//
import SwiftUI

struct ResultView: View {
    var image: UIImage?
    var result: String
    @State private var selectedGroupIndex: Int = 0
    @EnvironmentObject var arViewModel: ARViewModel
    
    var recommendation: GlassesRecommendation {
        getRecommendation(for: result)
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            VStack {
                Text("Face Shape Result:")
                    .font(.headline)
                    .padding(.top)
                
                Text(result)
                    .font(.title)
                    .bold()
                
                if let img = image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                
                Text(recommendation.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.top,10)
                
                Divider()
                    .padding(.vertical, 10)
                
                Text("Glasses Recommendations")
                    .font(.headline)
//                    .padding(.bottom, 4)
                
                LazyVGrid (columns: columns, spacing: 5){
                    ForEach(recommendation.groups, id: \.name) { group in
                        HStack{
                            VStack {
                                Image(group.name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 70)
                                    .cornerRadius(10)
                                
                                HStack (spacing: 5){
                                    ForEach(group.variants, id: \.modelFile) { variant in
                                        let color = Color(hex: variant.color)
                                        
                                        Circle()
                                            .fill(color)
                                            .frame(width: 15, height: 15)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.black)
                                            )
                                    }
                                }
                                
                                Text(group.name)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 3)
                            }
                            .padding(10)
                        }
//                                            .backgroundColor(Color.white.opacity(0.8))
                    }
                }
                .padding(.bottom)
                
                NavigationLink(destination: TryGlassesView(result: result).environmentObject(arViewModel)) {
                    Text("👓 Try Glasses")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let dummyImage = UIImage(systemName: "person.circle") // contoh placeholder
    let dummyResult = "Oval" // bisa diganti dengan "Round", "Heart", dll
    
    return NavigationView {
        ResultView(image: dummyImage, result: dummyResult)
            .environmentObject(ARViewModel()) // supaya tidak error
    }
}
