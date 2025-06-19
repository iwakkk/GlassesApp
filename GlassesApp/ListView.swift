////
////  ListView.swift
////  GlassesApp
////
////  Created by Edward Suwandi on 19/06/25.
////
//
//import SwiftUI
//import RealityKit
//
//struct ListView: View {
//    @EnvironmentObject var arViewModel: ARViewModel
//
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 16) {
//                ForEach(Array(arViewModel.glassesModels.enumerated()), id: \.offset) { index, modelName in
//                    VStack {
////                        Model3D(named: modelName)
////                            .frame(height: 100)
////                            .clipShape(RoundedRectangle(cornerRadius: 12))
////                            .shadow(radius: 4)
//
//                        Text(arViewModel.glassesNames[index])
//                            .font(.headline)
//                            .foregroundColor(.primary)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(12)
//                    .shadow(radius: 4)
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Glasses List")
//    }
//}
//
//
//#Preview {
//    ListView()
//           .environmentObject(ARViewModel())
//}
