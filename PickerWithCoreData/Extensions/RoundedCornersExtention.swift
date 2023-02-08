//
//  RoundedCornersExtention.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/02/01.
//

import Foundation
import SwiftUI

// Code copied from https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
