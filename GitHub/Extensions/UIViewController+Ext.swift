//
//  UIViewController+Ext.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = AlertViewController(title: "Something Went Wrong",
                                          message: "We were unable to complete your task at this time. Please try again.",
                                          buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}
