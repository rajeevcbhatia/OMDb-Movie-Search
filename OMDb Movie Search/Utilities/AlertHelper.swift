//
//  AlertHelper.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 28/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import Foundation

class AlertHelper {
    
    private init() {}
    
    static func display(presenter: UIViewController, title: String, message: String, dismissCompletion: ((UIAlertAction) -> Void)?) {
        let alertAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: dismissCompletion)
        let alertController = UIAlertController( title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(alertAction)
        presenter.present(alertController, animated: true, completion: nil)
    }
    
}
