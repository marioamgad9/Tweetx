//
//  PrimaryButton.swift
//  Common
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit

public class PrimaryButton: UIButton {
    // MARK: - Properties
    public override var isEnabled: Bool {
        didSet {
            setColors(enabled: isEnabled)
        }
    }
    private var color: UIColor = Color.primary.value
    private var textColor: UIColor = Color.secondary.value
    
    // MARK: - Initializers
    public init(color: UIColor, textColor: UIColor, frame: CGRect = .zero) {
        self.color = color
        self.textColor = textColor
        super.init(frame: frame)
        setupButton()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    // MARK: - Methods
    private func setupButton() {
        // Corner radius
        layer.cornerRadius = Dimens.cornerRadius
        
        // Set colors
        setColors(enabled: isEnabled)
        
        // Set title font
        titleLabel?.font = UIFont.bold(size: .normal)
        
        // Set content edge insets
        contentEdgeInsets = UIEdgeInsets.init(top: Dimens.buttonVerticalPadding,
                                              left: Dimens.buttonHorizontalPadding,
                                              bottom: Dimens.buttonVerticalPadding,
                                              right: Dimens.buttonHorizontalPadding)
    }
    
    private func setColors(enabled: Bool) {
        if enabled {
            setTitleColor(textColor, for: .normal)
            backgroundColor = color
        } else {
            setTitleColor(Color.white.value, for: .normal)
            backgroundColor = Color.lightGrey.value
        }
    }
    
    // MARK: - Animations
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = 0.8
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        alpha = 1
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        alpha = 1
    }
}
