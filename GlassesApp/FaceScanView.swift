import SwiftUI

struct FaceScanView: View {
    @EnvironmentObject var arViewModel: ARViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("Place your face here")
                    .foregroundColor(.black)
                    .font(.title3)
                    .padding()

                ZStack {
                    ARViewContainer()
                        .frame(width: 300, height: 300)
                        .cornerRadius(16)
                        .mask(
                            Ellipse()
                                .frame(width: 300, height: 300)
                        )
                        .overlay(
                            Ellipse()
                                .stroke(Color.green, lineWidth: 3)
                        )
                }

                Spacer()

                Button("🔍 Check My Face Shape") {
                    arViewModel.classifyFaceShape()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())

                NavigationLink(
                    destination: ResultView(image: arViewModel.capturedImage, result: arViewModel.faceShapeResult)
                        .environmentObject(arViewModel),
                    isActive: $arViewModel.showResultPage
                ) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .padding(.top, 90)


        }
    }
}
