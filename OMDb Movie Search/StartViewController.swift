//
//  ViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit
import PopupDialog

class StartViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.becomeFirstResponder()
            textField.delegate = self
        }
    }
    
    @IBAction func btnGoClicked() {
        
        textField.resignFirstResponder()
        guard let text = textField.text, text.trimmingCharacters(in: CharacterSet.whitespaces) != "" else {
            
            showNoTextPopup()
            return
            
        }
        performSegue(withIdentifier: "moviesListSegue", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func showNoTextPopup() {
        let title = "Invalid search term"
        let message = "Please enter a non empty search term!"
        
        let popup = PopupDialog(title: title, message: message)
        let cancelButton = CancelButton(title: "CANCEL") { [weak self] in
            self?.textField.becomeFirstResponder()
        }
        
        popup.addButton(cancelButton)
        
        self.present(popup, animated: true, completion: nil)
    }

}

extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        btnGoClicked()
        return true
    }
    
}
