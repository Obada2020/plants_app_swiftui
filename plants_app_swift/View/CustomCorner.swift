//
//  CustomCorner.swift
//  plants_app_swift
//
//  Created by Obada Alhalabi on 26/06/2024.
//

import SwiftUI

// MARK: Custom Corner Path Shape
struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
