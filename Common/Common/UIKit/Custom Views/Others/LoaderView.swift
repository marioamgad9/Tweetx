import UIKit
import Lottie

public enum LoaderStyle {
    case solid
    case transparent
    case colored(UIColor, UIColor)
    case noBackground
    
    func getBackgroundColor() -> UIColor {
        switch self {
        case .solid:
            return Color.darkestGrey.value
        case .transparent:
            return Color.darkestGrey.withAlpha(0.8)
        case .colored(let backgroundColor, _):
            return backgroundColor
        case .noBackground:
            return .clear
        }
    }
    
    func getContentColor() -> UIColor {
        switch self {
        case .solid:
            return Color.white.value
        case .transparent:
            return Color.white.value
        case .colored(_, let contentColor):
            return contentColor
        case .noBackground:
            return Color.white.value
        }
    }
}

public class LoaderView: NiblessView {
    
    // MARK: - Properties
    // Views
    private let loaderAnimation: AnimationView = {
        let animationView = AnimationView()
        let animation = Animation.named("twitter-animation")
        animationView.animation = animation
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = LottieBackgroundBehavior.pauseAndRestore
        return animationView
    }()
    
    private let loadingLabel: UILabel = {
        let loadingLabel = UILabel()
        loadingLabel.font = UIFont.light(size: .normal)
        loadingLabel.text = "label.loading".localized
        loadingLabel.numberOfLines = 0
        return loadingLabel
    }()
    
    // Customizable properties
    public var style: LoaderStyle! {
        didSet {
            backgroundColor = style.getBackgroundColor()
            loaderAnimation.tintColor = style.getContentColor()
            loadingLabel.textColor = style.getContentColor()
        }
    }
    public var animated: Bool!
    
    // MARK: - Methods
    public init(style: LoaderStyle = .solid,
                animated: Bool = true) {
        super.init(frame: .zero)
        setValues(style: style, animated: animated)
    }
    
    /// Helper method to make sure the didSet in 'style' property gets called on the initializer
    private func setValues(style: LoaderStyle, animated: Bool) {
        self.style = style
        self.animated = animated
    }
    
    public override func configureViewHierarchy() {
        // Configure root stackview
        let rootStackView = UIStackView(arrangedSubviews: [loaderAnimation, loadingLabel])
        rootStackView.axis = .vertical
        rootStackView.alignment = .center
        rootStackView.distribution = .fill
        rootStackView.spacing = 8
        
        rootStackView.add(loaderAnimation, then: {
            $0.constrainHeight(200)
            $0.constrainWidth(200)
        })
        rootStackView.add(loadingLabel)
        
        add(rootStackView, then: {
            $0.anchor(.leading(safeAreaLayoutGuide.leadingAnchor, constant: 16),
                      .trailing(safeAreaLayoutGuide.trailingAnchor, constant: -16),
                      .topGreaterThanOrEqualTo(safeAreaLayoutGuide.topAnchor, constant: 8),
                      .bottomLessThanOrEqualTo(safeAreaLayoutGuide.bottomAnchor, constant: -16))
            $0.centerXTo(safeAreaLayoutGuide.centerXAnchor)
            $0.centerYTo(safeAreaLayoutGuide.centerYAnchor)
        })
    }
    
    public override func viewHierarchyDidConfigure() {
        if animated {
            setInitialState()
            animateEntrance()
        }
        
        loaderAnimation.play()
        loadingLabel.animateEndlessBlinking()
    }
}

// MARK: - Animations
extension LoaderView {
    private func setInitialState() {
        loaderAnimation.alpha = 0
        loadingLabel.alpha = 0
        backgroundColor = .clear
    }
    
    private func animateEntrance() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
            self.loaderAnimation.alpha = 1
            self.loadingLabel.alpha = 1
            self.backgroundColor = self.style.getBackgroundColor()
        }, completion: nil)
    }
}
