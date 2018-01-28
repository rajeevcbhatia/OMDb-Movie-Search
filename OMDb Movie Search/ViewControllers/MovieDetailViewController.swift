//
//  MovieDetailViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 1/25/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    var itemId = ""
    
    var item: OMDbItem? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.loadUI()
            }
        }
    }

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator()
        APIClient.getMovieDetails(id: itemId) { [weak self] (item) in
            self?.hideLoadingIndicator()
            guard let loadedItem = item else {
                if let strongSelf = self {
                    AlertHelper.display(presenter: strongSelf, title: OMSStrings.couldNotLoadDetailsTitle, message: OMSStrings.couldNotLoadDetailsMessage, dismissCompletion: { [weak self] (action) in
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
                return
                
            }
            self?.item = loadedItem
        }
    }
    
    func loadUI() {
        guard let loadedItem = item else { return }
        
        posterImageView.sd_setImage(with: URL(string:loadedItem.posterUrlString ?? ""), completed: nil)
        
        typeLabel.text = item?.type?.uppercased() ?? ""
        nameLabel.text = item?.title?.uppercased() ?? ""
        plotLabel.text = item?.plot ?? ""
    }

}
