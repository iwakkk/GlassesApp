//
//  GlassesRecommendation.swift
//  GlassesApp
//
//  Created by Felicia Stevany Lewa on 16/06/25.
//
import SwiftUI

struct GlassesRecommendation {
    let faceShape: String
    let imageName: [String]
    let description: String
}

func getRecommendation(for shape: String) -> GlassesRecommendation {
    switch shape.lowercased() {
    case "oval":
        return GlassesRecommendation(
            faceShape: "Oval",
            imageName: ["oval_recommend 1", "oval_recommend 2", "oval_recommend 3"],
            description: "Bentuk wajah oval cocok dengan hampir semua jenis kacamata. Cobalah yang persegi atau aviator."
        )
    case "round":
        return GlassesRecommendation(
            faceShape: "Round",
            imageName: ["round_recommend 1", "round_recommend 2", "round_recommend 3"],
            description: "Pilih kacamata berbentuk persegi panjang atau geometris untuk memberikan kesan wajah lebih tegas."
        )
    case "square":
        return GlassesRecommendation(
            faceShape: "Square",
            imageName: ["square_recommend 1", "square_recommend 2", "square_recommend 3"],
            description: "Gunakan kacamata bulat atau oval untuk menyeimbangkan garis rahang yang tegas."
        )
    case "heart":
        return GlassesRecommendation(
            faceShape: "Heart",
            imageName: ["heart_recommend 1", "heart_recommend 2", "heart_recommend 3"],
            description: "Frame tipis atau bawah yang lebih lebar cocok untuk wajah berbentuk hati."
        )
    default:
        return GlassesRecommendation(
            faceShape: "Unknown",
            imageName: ["default_recommend 1", "default_recommend 2", "default_recommend 3"],
            description: "Coba berbagai jenis kacamata untuk melihat mana yang paling cocok."
        )
    }
}
