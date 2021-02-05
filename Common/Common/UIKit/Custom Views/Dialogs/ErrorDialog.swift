import UIKit

/// A dialog that represents an error in the app
public class ErrorDialog: NiblessViewController, DialogPopupDelegate {
    
    // MARK: - DialogPopupDelegate
    public var popupViewController: DialogPopupViewController?
    public var allowsTapToDismissPopupDialog = true
    public var allowsSwipeToDismissPopupDialog = true
    
    // MARK: - Views
    private let errorImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic-error"))
        imageView.tintColor = Color.secondary.value
        return imageView
    }()
    
    private let errorImageCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primary.value
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.primary.value
        label.font = UIFont.bold(size: .big)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkestGrey.value
        label.font = UIFont.regular(size: (.normal))
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let callToActionButton = PrimaryButton()
    
    
    // MARK: - Properties
    public var errorTitle: String {
        didSet {
            titleLabel.text = errorTitle
        }
    }
    
    public var errorMessage: String {
        didSet {
            messageLabel.text = errorMessage
        }
    }
    
    public var callToActionLabel: String {
        didSet {
            callToActionButton.setTitle(callToActionLabel, for: .normal)
        }
    }
    
    public var callToActionResponse: (() -> Void)?
    
    // MARK: - Initializer
    public init(errorTitle: String,
                errorMessage: String,
                callToActionLabel: String,
                callToActionResponse: (() -> Void)?) {
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.callToActionLabel = callToActionLabel
        self.callToActionResponse = callToActionResponse
        super.init()
        
        // Set initial values to labels & buttons
        titleLabel.text = errorTitle
        messageLabel.text = errorMessage
        callToActionButton.setTitle(callToActionLabel, for: .normal)
        
        // Add target for call to action
        callToActionButton.addTarget(self, action: #selector(callToActionClicked), for: .touchUpInside)
    }
    
    // MARK: - Methods
    @objc
    private func callToActionClicked() {
        popupViewController?.close()
        callToActionResponse?()
    }
    
    public override func configureViewHierarchy() {
        // Configure header image
        errorImageCircleView.add(errorImageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 50),
                $0.widthAnchor.constraint(equalToConstant: 50),
                $0.centerYAnchor.constraint(equalTo: errorImageCircleView.centerYAnchor),
                $0.centerXAnchor.constraint(equalTo: errorImageCircleView.centerXAnchor)
            ])
        })
        
        view.add(errorImageCircleView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 80),
                $0.widthAnchor.constraint(equalToConstant: 80),
                $0.topAnchor.constraint(equalTo: view.topAnchor, constant: -40),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        })
        
        // Configure title
        view.add(titleLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: errorImageCircleView.bottomAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        })
        
        // Configure message
        view.add(messageLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        })
        
        // Configure call to action
        view.add(callToActionButton, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
                $0.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            // Set corner radius for button
            $0.layer.cornerRadius = Dimens.cornerRadius
        })
    }
}
