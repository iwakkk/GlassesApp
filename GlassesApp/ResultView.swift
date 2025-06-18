//  ResultView.swift
//  GlassesApp
//
//  Created by Felicia Stevany Lewa on 16/06/25.
//
import SwiftUI

struct ResultView: View {
    var image: UIImage?
    var result: String
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
            
            Divider()
                .padding(.vertical)

            Text("Glasses Recommendations")
                .font(.headline)
                .padding(.bottom, 4)

            HStack {
                ForEach(recommendation.imageName.indices, id: \.self) { index in
                    Image(recommendation.imageName[index])
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                }
            }

            Text(recommendation.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: TryGlassesView().environmentObject(arViewModel)) {
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
