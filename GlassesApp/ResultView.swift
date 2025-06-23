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
    
    @State private var glassesShape = ""
    
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
                        .frame(width: 150, height: 150)
                }
                
                Text(recommendation.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.top)
                
                Divider()
                    .padding()
                
                Text("Glasses Recommendations")
                    .font(.title3.bold())
                
//                Picker("Glasses Recommendations", selection: $arViewModel.currentGroupIndex) {
//                    ForEach (0..<recommendation.groups.count, id: \.self) { index in
//                        Text(recommendation.groups[index].name)
//                    }
//                    Text("Red").tag(0) //tag = glassesShape
//                    Text("Green").tag(1)
//                    Text("Blue").tag(2)
//                }
//                .pickerStyle(.segmented)
//                .padding(.vertical, 10)
                
//                Menu {
//                    ForEach(0..<recommendation.groups.count, id: \.self) { index in
//                        Button(recommendation.groups[index].name) {
//                            arViewModel.currentGroupIndex = index
//                        }
//                    }
//                } label: {
//                    Label("Select Glasses Group", systemImage: "eyeglasses")
//                        .padding()
//                        .background(Color.blue.opacity(0.1))
//                        .cornerRadius(8)
//                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<recommendation.groups.count, id: \.self) { index in
                            Text(recommendation.groups[index].name)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(arViewModel.currentGroupIndex == index ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(arViewModel.currentGroupIndex == index ? .white : .primary)
                                .cornerRadius(20)
                                .onTapGesture {
                                    arViewModel.currentGroupIndex = index
                                }
                        }
                    }
                }
                .padding(.vertical, 10)


//                ScrollView(.horizontal, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(recommendation.groups, id: \.name) { group in
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
                                        .frame(width: 10, height: 10)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.black)
                                        )
                                }
                            }
                            
                            Text(group.name)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding(.top, 1)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(20)
                    }
                    
                }
//                .padding()
                
                NavigationLink(destination: TryGlassesView(result: result).environmentObject(arViewModel)) {
                    Text("👓 Try Glasses")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
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
