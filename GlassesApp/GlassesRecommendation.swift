//
//  GlassesRecommendation.swift
//  GlassesApp
//
//  Created by Felicia Stevany Lewa on 16/06/25.
//
import SwiftUI

//struct GlassesVariant {
//    let modelFile: String       // e.g., "RoundRed.usdz"
//    let displayName: String     // e.g., "Merah"
//    let color: String           // e.g., "#FF0000"
//}
//
//struct GlassesGroup {
//    let name: String                    // e.g., "Round"
//    let variants: [GlassesVariant]     // All color variants
//}
//
//struct GlassesRecommendation {
//    let faceShape: String
//    let groups: [GlassesGroup]
//    let description: String
//}
//
//func getRecommendation(for shape: String) -> GlassesRecommendation {
//    switch shape.lowercased() {
//    case "oval":
//        return GlassesRecommendation(
//            faceShape: "Oval",
//            groups: [
//                GlassesGroup(name: "Round", variants: [
//                    GlassesVariant(modelFile: "RoundBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "RoundBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "RoundSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "RoundGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "RoundTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Cat Eye", variants: [
//                    GlassesVariant(modelFile: "CatEyeBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "CatEyeBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "CatEyeSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "CatEyeGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "CatEyeTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Rectangle", variants: [
//                    GlassesVariant(modelFile: "RectangleBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "RectangleBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "RectangleSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "RectangleGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "RectangleTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Wayfare", variants: [
//                    GlassesVariant(modelFile: "WayfareBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "WayfareBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "WayfareSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "WayfareGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "WayfareTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Square", variants: [
//                    GlassesVariant(modelFile: "SquareBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "SquareBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "SquareSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "SquareGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "SquareTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Aviators", variants: [
//                    GlassesVariant(modelFile: "AviatorsBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "AviatorsBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "AviatorsSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "AviatorsGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "AviatorsTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Geometric", variants: [
//                    GlassesVariant(modelFile: "GeometricBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "GeometricBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "GeometricSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "GeometricGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "GeometricTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Browline", variants: [
//                    GlassesVariant(modelFile: "BrowlineBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "BrowlineBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "BrowlineSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "BrowlineGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "BrowlineTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Oval", variants: [
//                    GlassesVariant(modelFile: "OvalBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "OvalBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "OvalSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "OvalGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "OvalTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ])
//            ],
//            description: "Oval faces have balanced proportions and softly rounded contours, making them suitable for almost any eyewear style."
//        )
//    case "round":
//        return GlassesRecommendation(
//            faceShape: "Round",
//            groups: [
//                GlassesGroup(name: "Rectangle", variants: [
//                    GlassesVariant(modelFile: "RectangleBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "RectangleBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "RectangleSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "RectangleGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "RectangleTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Square", variants: [
//                    GlassesVariant(modelFile: "SquareBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "SquareBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "SquareSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "SquareGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "SquareTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Aviators", variants: [
//                    GlassesVariant(modelFile: "AviatorsBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "AviatorsBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "AviatorsSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "AviatorsGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "AviatorsTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Geometric", variants: [
//                    GlassesVariant(modelFile: "GeometricBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "GeometricBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "GeometricSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "GeometricGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "GeometricTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ])
//            ],
//            description: "Round faces are characterized by full cheeks and a rounded chin with equal width and height, giving a soft and youthful appearance."
//        )
//    case "square":
//        return GlassesRecommendation(
//            faceShape: "Square",
//            groups: [
//                GlassesGroup(name: "Round", variants: [
//                    GlassesVariant(modelFile: "RoundBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "RoundBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "RoundSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "RoundGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "RoundTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Cat Eye", variants: [
//                    GlassesVariant(modelFile: "CatEyeBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "CatEyeBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "CatEyeSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "CatEyeGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "CatEyeTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Wayfare", variants: [
//                    GlassesVariant(modelFile: "WayfareBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "WayfareBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "WayfareSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "WayfareGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "WayfareTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Aviators", variants: [
//                    GlassesVariant(modelFile: "AviatorsBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "AviatorsBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "AviatorsSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "AviatorsGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "AviatorsTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Browline", variants: [
//                    GlassesVariant(modelFile: "BrowlineBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "BrowlineBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "BrowlineSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "BrowlineGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "BrowlineTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Oval", variants: [
//                    GlassesVariant(modelFile: "OvalBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "OvalBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "OvalSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "OvalGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "OvalTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ])
//            ],
//            description: "Square faces have a broad forehead, strong jawline, and angular features with equal width from forehead to jaw."
//        )
//    case "heart":
//        return GlassesRecommendation(
//            faceShape: "Heart",
//            groups: [
//                GlassesGroup(name: "Cat Eye", variants: [
//                    GlassesVariant(modelFile: "CatEyeBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "CatEyeBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "CatEyeSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "CatEyeGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "CatEyeTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Rectangle", variants: [
//                    GlassesVariant(modelFile: "RectangleBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "RectangleBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "RectangleSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "RectangleGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "RectangleTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Wayfare", variants: [
//                    GlassesVariant(modelFile: "WayfareBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "WayfareBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "WayfareSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "WayfareGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "WayfareTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Browline", variants: [
//                    GlassesVariant(modelFile: "BrowlineBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "BrowlineBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "BrowlineSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "BrowlineGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "BrowlineTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Oval", variants: [
//                    GlassesVariant(modelFile: "OvalBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "OvalBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "OvalSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "OvalGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "OvalTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ])
//            ],
//            description: "Heart-shaped faces feature a wide forehead and cheekbones with a narrow chin, forming a silhouette similar to an inverted triangle."
//        )
//    case "oblong":
//        return GlassesRecommendation(
//            faceShape: "Oblong",
//            groups: [
//                GlassesGroup(name: "Cat Eye", variants: [
//                    GlassesVariant(modelFile: "CatEyeBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "CatEyeBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "CatEyeSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "CatEyeGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "CatEyeTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Rectangle", variants: [
//                    GlassesVariant(modelFile: "RectangleBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "RectangleBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "RectangleSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "RectangleGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "RectangleTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Wayfare", variants: [
//                    GlassesVariant(modelFile: "WayfareBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "WayfareBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "WayfareSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "WayfareGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "WayfareTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Browline", variants: [
//                    GlassesVariant(modelFile: "BrowlineBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "BrowlineBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "BrowlineSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "BrowlineGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "BrowlineTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ]),
//                GlassesGroup(name: "Oval", variants: [
//                    GlassesVariant(modelFile: "OvalBlack.usdz", displayName: "Black", color: "#121212"),
//                    GlassesVariant(modelFile: "OvalBrown.usdz", displayName: "Brown", color: "#8A4B24"),
//                    GlassesVariant(modelFile: "OvalSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
//                    GlassesVariant(modelFile: "OvalGold.usdz", displayName: "Gold", color: "#D6B157"),
//                    GlassesVariant(modelFile: "OvalTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
//                ])
//            ],
//            description: "Oblong faces are longer than they are wide, with straighter cheek lines and often a more elongated chin and forehead."
//        )
//    default:
//        return GlassesRecommendation(
//            faceShape: "Unknown",
//            groups: [],
//            description: "This face shape doesn’t match a specific category. Explore different styles to discover what looks best on you."
//        )
//    }
//}


struct GlassesRecommendation {
    let faceShape: String
    let imageName: [String]
    let glassesName: [String]
    let description: String
}

func getRecommendation(for shape: String) -> GlassesRecommendation {
    switch shape.lowercased() {
    case "oval":
        return GlassesRecommendation(
            faceShape: "Oval",
            imageName: ["Round.usdz", "Cat Eye.usdz", "Rectangle.usdz", "Wayfare.usdz", "Square.usdz", "Aviators.usdz", "Geometric.usdz", "Browline.usdz", "Oval.usdz"],
            glassesName: ["Round", "Cat Eye", "Rectangle", "Wayfare", "Square", "Aviators", "Geometric", "Browline", "Oval"],
            description: "Bentuk wajah oval cocok dengan hampir semua jenis kacamata. Cobalah yang persegi atau aviator."
        )
    case "round":
        return GlassesRecommendation(
            faceShape: "Round",
            imageName: ["Rectangle.usdz", "Square.usdz", "Aviators.usdz", "Geometric.usdz"],
            glassesName: ["Rectangle", "Square", "Aviators", "Geometric"],
            description: "Pilih kacamata berbentuk persegi panjang atau geometris untuk memberikan kesan wajah lebih tegas."
        )
    case "square":
        return GlassesRecommendation(
            faceShape: "Square",
            imageName: ["Round.usdz", "Cat Eye.usdz", "Wayfare.usdz", "Aviators.usdz", "Browline.usdz", "Oval.usdz"],
            glassesName: ["Round", "Cat Eye", "Wayfare", "Aviators", "Browline", "Oval"],
            description: "Gunakan kacamata bulat atau oval untuk menyeimbangkan garis rahang yang tegas."
        )
    case "heart":
        return GlassesRecommendation(
            faceShape: "Heart",
            imageName: ["Cat Eye.usdz", "Rectangle.usdz", "Wayfare.usdz", "Browline.usdz", "Oval.usdz"],
            glassesName: ["Cat Eye", "Rectangle", "Wayfare", "Browline", "Oval"],
            description: "Frame tipis atau bawah yang lebih lebar cocok untuk wajah berbentuk hati."
        )
    case "oblong":
        return GlassesRecommendation(
            faceShape: "Oblong",
            imageName: ["Round.usdz", "Cat Eye.usdz", "Wayfare.usdz", "Square.usdz"],
            glassesName: ["Round", "Cat Eye", "Wayfare", "Square"],
            description: ""
        )
    default:
        return GlassesRecommendation(
            faceShape: "Unknown",
            imageName: ["default_recommend 1", "default_recommend 2", "default_recommend 3"],
            glassesName: ["default_recommend 1", "default_recommend 2", "default_recommend 3"],
            description: "Coba berbagai jenis kacamata untuk melihat mana yang paling cocok."
        )
    }
}
