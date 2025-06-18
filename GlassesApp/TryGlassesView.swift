import SwiftUI

struct TryGlassesView: View {
    @EnvironmentObject var arViewModel: ARViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding()

                Spacer()

                VStack(spacing: 10) {
                    Text("Model: \(arViewModel.glassesNames[arViewModel.currentIndex])")
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)

                    HStack {
                        Button(action: {
                            arViewModel.previousGlasses()
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                        }

                        Button(action: {
                            arViewModel.nextGlasses()
                        }) {
                            Image(systemName: "chevron.right.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                        }
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            arViewModel.shouldDisplayModel = true
            arViewModel.hasAddedModel = false
        }
        .onDisappear {
            arViewModel.shouldDisplayModel = false
            arViewModel.hasAddedModel = false
        }
    }
}
