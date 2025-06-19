import SwiftUI
import RealityKit
import ARKit
import CoreML
import Vision

struct ContentView: View {
    @EnvironmentObject var arViewModel: ARViewModel

    var body: some View {
        TabView {
            FaceScanView()
                .tabItem {
                    Label("Glasses", systemImage: "eyeglasses")
                }

            FaceScanView()
                .tabItem {
                    Label("Scan", systemImage: "faceid")
                }

            FaceScanView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
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

//
