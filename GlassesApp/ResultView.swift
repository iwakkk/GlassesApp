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

    var body: some View {
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
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Divider()
                .padding(.vertical)

            Text("Glasses Recommendations")
                .font(.headline)
                .padding(.bottom, 4)

            //Button color
//            HStack {
//                ForEach(recommendation.groups.indices, id: \.self) { index in
//                    let group = recommendation.groups[index]
//                    // tampilkan nama group atau tombol pilihan
//                    let selectedGroup = recommendation.groups[selectedGroupIndex]
//                    
//                    ForEach(selectedGroup.variants, id: \.modelFile) { variant in
//                        Text(variant.displayName)
//                        
//                        VStack {
//                            Image(group.displayName) // pastikan nama image cocok dengan asset di project
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: 150)
//                                .cornerRadius(10)
//                            
//                            Text(group.displayName)
//                                .font(.caption)
//                        }
//                    }
//                }
//            }
            
            HStack {
                ForEach(recommendation.glassesName.indices, id: \.self) { index in
                    Image(recommendation.glassesName[index])
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                }
            }
 
//            Text(recommendation.description)
//                .font(.body)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: TryGlassesView(result: result).environmentObject(arViewModel)) {
                Text("👓 Try Glasses")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .padding(.top)
        }
        .padding()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
