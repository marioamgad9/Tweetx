//
//  UIViewController+ErrorPresentation.swift
//  TXKit
//
//  Created by Mario Mouris on 05/02/2021.
//

import UIKit
import Common

extension UIViewController {
    /// Presents an error message
    public func present(errorMessage: ErrorMessage) {
        let errorVc = ErrorDialog(errorTitle: errorMessage.title,
                                  errorMessage: errorMessage.message,
                                  callToActionLabel: errorMessage.callToActionLabel,
                                  callToActionResponse: errorMessage.callToActionResponse)
        let errorDialog = DialogPopupViewController(contentViewController: errorVc)
        errorDialog.show(onViewController: self)
    }
}

