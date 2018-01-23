//
//  ViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit

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
        
        guard let text = textField.text, text.trimmingCharacters(in: CharacterSet.whitespaces) != "" else {
            
            //show popup
            print("nope")
            textField.becomeFirstResponder()
            return
            
        }
        print("success")
        textField.resignFirstResponder()
        performSegue(withIdentifier: "moviesListSegue", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

}

extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        btnGoClicked()
        return true
    }
    
}
