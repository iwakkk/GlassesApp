import SwiftUI
import RealityKit
import ARKit
import CoreML
import Vision

struct ContentView: View {
    @EnvironmentObject var arViewModel: ARViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("Place your face here")
                    .foregroundColor(.black)
                    .font(.title3)

                ZStack {
                    ARViewContainer()
                        .frame(width: 300, height: 300)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
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
        
        NavigationLink(destination: TryGlassesView().environmentObject(arViewModel)) {
            Text("👓 Try Glasses")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        .padding(.top)
    }
}

// MARK: - UIImage to CVPixelBuffer Extension
extension UIImage {
    func toCVPixelBuffer() -> CVPixelBuffer? {
        guard let cgImage = self.cgImage else {
            print("❌ Gagal ambil CGImage dari UIImage")
            return nil
        }

        let width = cgImage.width
        let height = cgImage.height

        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue!,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue!
        ] as CFDictionary

        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32ARGB,
            attrs,
            &pixelBuffer
        )

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            print("❌ Gagal buat PixelBuffer")
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, [])
        let pixelData = CVPixelBufferGetBaseAddress(buffer)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(
            data: pixelData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        ) else {
            print("❌ Gagal buat CGContext")
            return nil
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        CVPixelBufferUnlockBaseAddress(buffer, [])

        return buffer
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .environmentObject(ARViewModel()) // agar preview tidak error
}
