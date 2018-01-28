//
//  ViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController {

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let moviesListVC = segue.destination as? MoviesListViewController, let searchTerm = textField.text {
            moviesListVC.currentSearchTerm = searchTerm.trimmingCharacters(in: CharacterSet.whitespaces)
        }
    }
    
    func showNoTextPopup() {
        let title = OMSStrings.noSearchTermTitle
        let message = OMSStrings.noSearchTermMessage
        
        AlertHelper.display(presenter: self, title: title, message: message, dismissCompletion: nil)
    }

}

extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        btnGoClicked()
        return true
    }
    
}
