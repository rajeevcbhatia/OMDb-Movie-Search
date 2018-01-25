//
//  MovieDetailViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 1/25/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var itemId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.getMovieDetails(id: itemId) { (item) in
            print(item)
        }
    }

}
