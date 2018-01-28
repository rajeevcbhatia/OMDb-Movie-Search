//
//  ViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController {

    //MARK:- outlets and actions
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.becomeFirstResponder()
            textField.delegate = self
        }
    }
    
    @IBAction func btnGoClicked() {
        
        textField.resignFirstResponder()
        guard let text = textField.text, text.trimmingCharacters(in: CharacterSet.whitespaces) != "" else {
            
            AlertHelper.display(presenter: self, title: OMSStrings.noSearchTermTitle, message: OMSStrings.noSearchTermMessage, dismissCompletion: nil)
            return
            
        }
        performSegue(withIdentifier: "moviesListSegue", sender: nil)
        
    }
    
    // MARK:- UIViewController methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let moviesListVC = segue.destination as? MoviesListViewController, let searchTerm = textField.text {
            moviesListVC.currentSearchTerm = searchTerm.trimmingCharacters(in: CharacterSet.whitespaces)
        }
    }

}

//MARK:- UITextFieldDelegate
extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        btnGoClicked()
        return true
    }
    
}
