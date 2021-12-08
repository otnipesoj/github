//
//  DataLoadingViewController.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

class DataLoadingViewController: UIViewController {

    var containerView: UIView!
    var emptyStateView: GHEmptyStateView!
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        if (containerView == nil) {
            return
        }
        
        self.containerView.removeFromSuperview()
        self.containerView = nil
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        if (emptyStateView != nil) {
            return
        }
        
        emptyStateView = GHEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        emptyStateView.backgroundColor = .systemBackground
        view.addSubview(emptyStateView)
    }
    
    func dismissEmptyStateView() {
        if (emptyStateView == nil) {
            return
        }
        
        self.emptyStateView.removeFromSuperview()
        self.emptyStateView = nil
    }
}
