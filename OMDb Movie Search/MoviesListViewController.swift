//
//  MoviesListViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    var currentSearchTerm = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        APIClient.getMoviesList(searchTerm: currentSearchTerm) { [weak self] (result) in
            guard let omdbItems = result else { return }
            
            print(omdbItems)
        }
    }

}
