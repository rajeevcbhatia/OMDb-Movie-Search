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
    
    var item: OMDbItem? {
        didSet {
            loadUI()
        }
    }

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.getMovieDetails(id: itemId) { [weak self] (item) in
            guard let loadedItem = item else {
                //show error
                return
                
            }
            self?.item = loadedItem
        }
    }
    
    func loadUI() {
        guard let loadedItem = item else { return }
        
        posterImageView.sd_setImage(with: URL(string:loadedItem.posterUrlString ?? ""), completed: nil)
    }

}
