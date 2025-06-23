import SwiftUI

// MARK: - Data Models

struct GlassesVariant {
    let modelFile: String       // e.g., "RoundRed.usdz"
    let displayName: String     // e.g., "Merah"
    let color: String           // e.g., "#FF0000"
}

struct GlassesGroup {
    let name: String                    // e.g., "RoundA"
    let category: String                // e.g., "Round"
    let variants: [GlassesVariant]     // All color variants
}

struct GlassesRecommendation {
    let faceShape: String
    let groups: [GlassesGroup]
    let description: String
}

// MARK: - Master List of All Glasses

let allGlassesGroups: [GlassesGroup] = [
    GlassesGroup(name: "Round A", category: "Round", variants: [
        GlassesVariant(modelFile: "RoundABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "RoundASilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "RoundAGold.usdz", displayName: "Gold", color: "#D6B157"),
        GlassesVariant(modelFile: "RoundATrans.usdz", displayName: "Transparent", color: "#F7F7F7")
    ]),
    GlassesGroup(name: "Round B", category: "Round", variants: [
        GlassesVariant(modelFile: "RoundBBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "RoundBSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "RoundBGold.usdz", displayName: "Gold", color: "#D6B157"),
        GlassesVariant(modelFile: "RoundBTrans.usdz", displayName: "Transparent", color: "#F7F7F7")
    ]),
    GlassesGroup(name: "CatEye A", category: "Cat Eye", variants: [
        GlassesVariant(modelFile: "CatEyeABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "CatEyeABrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "CatEyeABlue.usdz", displayName: "Blue", color: "#305BAB")
    ]),
    GlassesGroup(name: "Rectangle A", category: "Rectangle", variants: [
        GlassesVariant(modelFile: "RectangleABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "RectangleABrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "RectangleATrans.usdz", displayName: "Transparent", color: "#F7F7F7"),
        GlassesVariant(modelFile: "RectangleABlue.usdz", displayName: "Blue", color: "#305BAB")
    ]),
    GlassesGroup(name: "Rectangle B", category: "Rectangle", variants: [
        GlassesVariant(modelFile: "RectangleBBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "RectangleBBrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "RectangleBSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "RectangleBBlue.usdz", displayName: "Blue", color: "#305BAB")
    ]),
    GlassesGroup(name: "Rectangle C", category: "Rectangle", variants: [
        GlassesVariant(modelFile: "RectangleCBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "RectangleCSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "RectangleCGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Rectangle D", category: "Rectangle", variants: [
        GlassesVariant(modelFile: "RectangleDBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "RectangleDSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "RectangleDCGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Rectangle E", category: "Rectangle", variants: [
        GlassesVariant(modelFile: "RectangleEBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "RectangleESilver.usdz", displayName: "Silver", color: "#B0B0B0")
    ]),
    GlassesGroup(name: "Wayfare A", category: "Wayfare", variants: [
        GlassesVariant(modelFile: "WayfareABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "WayfareABrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "WayfareABlue.usdz", displayName: "Blue", color: "#305BAB")
    ]),
    GlassesGroup(name: "Square A", category: "Square", variants: [
        GlassesVariant(modelFile: "SquareABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "SquareABrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "SquareATrans.usdz", displayName: "Transparent", color: "#F7F7F7"),
        GlassesVariant(modelFile: "SquareABlue.usdz", displayName: "Blue", color: "#305BAB")
    ]),
    GlassesGroup(name: "Square B", category: "Square", variants: [
        GlassesVariant(modelFile: "SquareBBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "SquareBBrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "SquareBSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "SquareBGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Aviator A", category: "Aviators", variants: [
        GlassesVariant(modelFile: "AviatorABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "AviatorASilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "AviatorAGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Aviator B", category: "Aviators", variants: [
        GlassesVariant(modelFile: "AviatorBBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "AviatorBSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "AviatorBGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Geometric A", category: "Geometric", variants: [
        GlassesVariant(modelFile: "GeometricABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "GeometricABrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "GeometricASilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "GeometricAGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Geometric B", category: "Geometric", variants: [
        GlassesVariant(modelFile: "GeometricBBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "GeometricBBrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "GeometricBSilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "GeometricBGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Browline A", category: "Browline", variants: [
        GlassesVariant(modelFile: "BrowlineABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "BrowlineABrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "BrowlineASilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "BrowlineAGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Oval A", category: "Oval", variants: [
        GlassesVariant(modelFile: "OvalABlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "OvalABrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "OvalASilver.usdz", displayName: "Silver", color: "#B0B0B0"),
        GlassesVariant(modelFile: "OvalAGold.usdz", displayName: "Gold", color: "#D6B157")
    ]),
    GlassesGroup(name: "Oval B", category: "Oval", variants: [
        GlassesVariant(modelFile: "OvalBBlack.usdz", displayName: "Black", color: "#121212"),
        GlassesVariant(modelFile: "OvalBBrown.usdz", displayName: "Brown", color: "#8A4B24"),
        GlassesVariant(modelFile: "OvalBTrans.usdz", displayName: "Transparent", color: "#F7F7F7"),
        GlassesVariant(modelFile: "OvalBBlue.usdz", displayName: "Blue", color: "#305BAB")
    ])
]

// MARK: - Helper Function

func getGroups(fromCategories categories: [String]) -> [GlassesGroup] {
    return allGlassesGroups.filter { categories.contains($0.category) }
}

func getRecommendation(for shape: String) -> GlassesRecommendation {
    switch shape.lowercased() {
    case "oval":
        return GlassesRecommendation(
            faceShape: "Oval",
            groups: getGroups(fromCategories: ["Round", "Cat Eye", "Rectangle", "Wayfare", "Square", "Aviators", "Geometric", "Browline", "Oval"]),
            description: "Oval faces have balanced proportions and softly rounded contours, making them suitable for almost any eyewear style."
        )
    case "round":
        return GlassesRecommendation(
            faceShape: "Round",
            groups: getGroups(fromCategories: ["Rectangle", "Square", "Aviators", "Geometric"]),
            description: "Round faces are characterized by full cheeks and a rounded chin with equal width and height, giving a soft and youthful appearance."
        )
    case "square":
        return GlassesRecommendation(
            faceShape: "Square",
            groups: getGroups(fromCategories: ["Round", "Cat Eye", "Wayfare", "Aviators", "Browline", "Oval"]),
            description: "Square faces have a broad forehead, strong jawline, and angular features with equal width from forehead to jaw."
        )
    case "heart":
        return GlassesRecommendation(
            faceShape: "Heart",
            groups: getGroups(fromCategories: ["Cat Eye", "Rectangle", "Wayfare", "Browline", "Oval"]),
            description: "Heart-shaped faces feature a wide forehead and cheekbones with a narrow chin, forming a silhouette similar to an inverted triangle."
        )
    case "oblong":
        return GlassesRecommendation(
            faceShape: "Oblong",
            groups: getGroups(fromCategories: ["Cat Eye", "Rectangle", "Wayfare", "Browline", "Oval"]),
            description: "Oblong faces are longer than they are wide, with straighter cheek lines and often a more elongated chin and forehead."
        )
    default:
        return GlassesRecommendation(
            faceShape: "Unknown",
            groups: [],
            description: "This face shape doesn’t match a specific category. Explore different styles to discover what looks best on you."
        )
    }
}
