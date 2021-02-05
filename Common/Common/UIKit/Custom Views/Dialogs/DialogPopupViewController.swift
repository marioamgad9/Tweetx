import UIKit

public protocol DialogPopupDelegate: class {
    var popupViewController: DialogPopupViewController? { get set }
    var allowsTapToDismissPopupDialog: Bool { get }
}

public class DialogPopupViewController: UIViewController {
    
    // MARK: - Public Interface
    public var cornerRadius: CGFloat
    public var disableTapToDismiss = false
    public let contentViewController: UIViewController
    public var onCloseHandler: (() -> ())?
    
    public func show(onViewController viewController: UIViewController) {
        self.modalPresentationStyle = .overCurrentContext
        viewController.present(self, animated: false)
    }
    
    public func close(completionHandler: (() -> Void)? = nil) {
        animateOut(completionHandler: completionHandler)
    }
    
    // MARK: - Private Properties
    private let introAnimationDuration = 0.6
    private let outroAnimationDuration = 0.8
    private let backgroundOpacity = CGFloat(0.7)
    
    private let containerView = UIView(frame: .zero)
    private let contentView: UIView
    
    private var hasAnimatedIn = false
    
    private var state = State.animatingIn
    
    private var lastTimeStamp: CFTimeInterval?
    
    private var containerBottomConstraint: NSLayoutConstraint!
    private var containerOffscreenConstraint: NSLayoutConstraint!
    
    private var tapRecognizer: UITapGestureRecognizer!
    
    private var keyboardIsVisible = false
    
    private var popupProtocolResponder: DialogPopupDelegate? {
        if let protocolResponder = contentViewController as? DialogPopupDelegate {
            return protocolResponder
        } else {
            return nil
        }
    }
    
    // MARK: - State type
    enum State {
        case animatingIn
        case idle
        case animatingOut
    }
    
    // MARK: - Initializers
    public init(contentViewController viewController: UIViewController,
                cornerRadius: Int = Int(Dimens.cornerRadius)) {
        contentViewController = viewController
        contentView = viewController.view
        self.cornerRadius = CGFloat(cornerRadius)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background view
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = Dimens.cornerRadius
        backgroundView.layer.masksToBounds = true
        backgroundView.backgroundColor = Color.offWhite.value
        
        // Container view
        view.addSubview(containerView)
        view.add(backgroundView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                $0.topAnchor.constraint(equalTo: containerView.topAnchor),
                $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        })
        view.bringSubviewToFront(containerView)
        containerView.isUserInteractionEnabled = false
        
        // Content view
        addChild(contentViewController)
        containerView.addSubview(contentView)
        
        // Apply constraints
        applyContainerViewConstraints()
        applyContentViewConstraints()
        containerOffscreenConstraint.isActive = true
        
        // Tap outside recognizer
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        
        // Popup protocol responder
        popupProtocolResponder?.popupViewController = self
        
        // Subscribe to keyboard notifications
        subscribeToKeyboardNotifications()
        
        // Add listener to dismiss keyboard on tap
        contentViewController.hideKeyboardOnTap()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !hasAnimatedIn {
            animateIn()
            hasAnimatedIn = true
        }
    }
}

// MARK: - Keyboard notifications
extension DialogPopupViewController: KeyboardResponsive {
    public func keyboardWillShow(keyboardHeight: CGFloat) {
        // Update keyboardIsVisible variable
        keyboardIsVisible = true
        
        // Push center constraint
        containerBottomConstraint.constant = -keyboardHeight
        
        // Update with animations
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    public func keyboardWillHide() {
        // Update keyboardIsVisible variable
        keyboardIsVisible = false
        
        // Return to center constraint
        containerBottomConstraint.constant = -8
        
        // Update with animations
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Animations
extension DialogPopupViewController {
    private func animateIn() {
        // Animate background color
        UIView.animate(withDuration: introAnimationDuration,
                       delay: 0.0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        self.view.backgroundColor = UIColor(white: 0, alpha: self.backgroundOpacity)
        }, completion: nil)
        
        // Animate container on screen
        containerOffscreenConstraint.isActive = false
        self.view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: introAnimationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: [.allowUserInteraction],
                       animations: {
                        self.view.layoutIfNeeded()
                        self.containerView.alpha = 1
        }, completion: { _ in
            self.containerView.isUserInteractionEnabled = true
            self.state = .idle
        })
    }
    
    private func animateOut(completionHandler: (() -> Void)? = nil) {
        view.isUserInteractionEnabled = false
        state = .animatingOut
        
        // Animate background color
        UIView.animate(withDuration: outroAnimationDuration,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.view.backgroundColor = UIColor.clear
        })
        
        // Animate container off screen
        containerOffscreenConstraint.isActive = true
        view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: outroAnimationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.view.layoutIfNeeded()
                        self.containerView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: completionHandler)
            self.onCloseHandler?()
        })
    }
}

// MARK: - Gestures
extension DialogPopupViewController: UIGestureRecognizerDelegate {
    @objc private func tapOutside() {
        // Hide keyboard if visible and return
        if keyboardIsVisible {
            dismissKeyboard()
            return
        }
        
        if let protocolResponder = popupProtocolResponder {
            if protocolResponder.allowsTapToDismissPopupDialog {
                animateOut()
            }
        } else {
            animateOut()
        }
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == tapRecognizer {
            // Tap gesture triggered, check if it is outside the view
            if self.disableTapToDismiss {
                // Don't dismiss if the disable on tap is disabled
                return false
            }
            
            let location = tapRecognizer.location(in: view)
            return !containerView.frame.contains(location)
        }
        
        return true
    }
}

// MARK: - Constraints
extension DialogPopupViewController {
    private func applyContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [NSLayoutConstraint.Attribute.left, .right, .top, .bottom].forEach{
            
            let constraint = NSLayoutConstraint(item: contentView,
                                                attribute: $0,
                                                relatedBy: .equal,
                                                toItem: containerView,
                                                attribute: $0,
                                                multiplier: 1.0,
                                                constant: 0)
            containerView.addConstraint(constraint)
        }
    }
    
    private func applyContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let sideMargin = CGFloat(8)
        let verticalMargins = CGFloat(8)
        
        let left = NSLayoutConstraint(item: containerView,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: view.safeAreaLayoutGuide,
                                      attribute: .left,
                                      multiplier: 1.0,
                                      constant: sideMargin)
        
        let right = NSLayoutConstraint(item: containerView,
                                       attribute: .right,
                                       relatedBy: .equal,
                                       toItem: view.safeAreaLayoutGuide,
                                       attribute: .right,
                                       multiplier: 1.0,
                                       constant: -sideMargin)
        
        let top = NSLayoutConstraint(item: containerView,
                                     attribute: .top,
                                     relatedBy: .greaterThanOrEqual,
                                     toItem: view.safeAreaLayoutGuide,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: verticalMargins)
        
        containerBottomConstraint = NSLayoutConstraint(item: containerView,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: view.safeAreaLayoutGuide,
                                                       attribute: .bottom,
                                                       multiplier: 1.0,
                                                       constant: -verticalMargins)
        containerBottomConstraint.priority = UILayoutPriority.defaultHigh
        
        let limitHeight = NSLayoutConstraint(item: containerView,
                                             attribute: .height,
                                             relatedBy: .lessThanOrEqual,
                                             toItem: view.safeAreaLayoutGuide,
                                             attribute: .height,
                                             multiplier: 1.0,
                                             constant: -verticalMargins*2)
        limitHeight.priority = UILayoutPriority.defaultHigh
        
        containerOffscreenConstraint = NSLayoutConstraint(item: containerView,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: view,
                                                          attribute: .bottom,
                                                          multiplier: 1.0,
                                                          constant: 40)
        containerOffscreenConstraint.priority = UILayoutPriority.required
        
        view.addConstraints([top, left, right, containerBottomConstraint, limitHeight, containerOffscreenConstraint])
    }
}

// MARK: - Determine equality between two states
func ==(lhs: DialogPopupViewController.State, rhs: DialogPopupViewController.State) -> Bool {
    
    switch (lhs, rhs) {
    case (.animatingIn, .animatingIn):
        return true
    case (.idle, .idle):
        return true
    default:
        return false
    }
}


