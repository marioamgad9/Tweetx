import UIKit

extension UIFont {
    public static func getCustomFont(name: String, size: CGFloat, scalable: Bool) -> UIFont {
        guard let customFont = UIFont(name: name, size: size) else {
            fatalError("Failed to load the \(name) font")
        }
        
        if scalable {
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            return fontMetrics.scaledFont(for: customFont)
        } else {
            return customFont
        }
    }
    
    public static func light(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(name: FontNames.light,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    
    public static func regular(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(name: FontNames.regular,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    
    public static func medium(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(name: FontNames.medium,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    
    public static func bold(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(name: FontNames.bold,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    
    public static func extraBold(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(name: FontNames.extraBold,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
}

