//
//  BaseViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 28/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator()
    }

    deinit {
        print("deinit \(String(describing: self))")
    }
    
    //MARK:- activity indicator
    
    private func addActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.gray
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
    }
    
    /** shows a gray activity indicator in the center of the screen on the main thread */
    func showLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    /** hides the activity indicator */
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
