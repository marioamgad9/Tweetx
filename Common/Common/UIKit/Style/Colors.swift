import UIKit

public enum Color {
    
    // MARK: - Cases
    case primary
    case secondary
    case black
    case darkestGrey
    case lightGrey
    case lightestGrey
    case white
    case custom(hexString: String)
    
    // MARK: - Methods
    public func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

extension Color {
    public var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .primary:
            instanceColor = UIColor(hexString: "#C12031")
        case .secondary:
            instanceColor = UIColor(hexString: "#F5F0E3")
        case .black:
            instanceColor = UIColor(hexString: "#000000")
        case .darkestGrey:
            instanceColor = UIColor(hexString: "#131213")
        case .lightGrey:
            instanceColor = UIColor(hexString: "#696969")
        case .lightestGrey:
            instanceColor = UIColor(hexString: "#D3D1D1")
        case .white:
            instanceColor = UIColor(hexString: "#ffffff")
        case .custom(let hexValue):
            instanceColor = UIColor(hexString: hexValue)
        }
        return instanceColor
    }
}
