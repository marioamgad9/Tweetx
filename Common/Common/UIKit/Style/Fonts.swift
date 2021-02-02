import UIKit

/// The font names used in the app.
/// These are just the names, to access the fonts, check UIFont+Extensions
struct FontNames {
    static let light = "SourceSansPro-Light"
    static let regular = "SourceSansPro-Regular"
    static let medium = "SourceSansPro-SemiBold"
    static let bold = "SourceSansPro-Bold"
    static let extraBold = "SourceSansPro-Black"
}

/// Enum holding font sizes
public enum FontSize: Int {
    case micro = 10
    case small = 12
    case normal = 14
    case big = 16
    case huge = 18
    case enormous = 24
}
