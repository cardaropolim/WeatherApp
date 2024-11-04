import Foundation
import SwiftUI

// Extension pour arrondir les nombres à un chiffre sans décimales
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

// Extension pour personnaliser le coin d'un View
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// Structure pour arrondir des coins spécifiques
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
