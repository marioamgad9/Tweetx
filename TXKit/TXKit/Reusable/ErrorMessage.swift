import Foundation
import Common

public struct ErrorMessage: Error {
    
    // MARK: - Properties
    public let id: UUID
    public let title: String
    public let message: String
    public let callToActionLabel: String
    public let callToActionResponse: (() -> Void)?
    
    // MARK: - Methods
    public init(title: String,
                message: String,
                callToActionLabel: String = "btn.default_okay".localized,
                callToActionResponse: (() -> Void)? = nil) {
        self.id = UUID()
        self.title = title
        self.message = message
        self.callToActionLabel = callToActionLabel
        self.callToActionResponse = callToActionResponse
    }
}
