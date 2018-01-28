//
//  MoviesListViewController.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListViewController: BaseViewController {

    //MARK:- Outlets and actions
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
        }
    }
    
    //MARK:- custom properties
    var currentSearchTerm = ""
    
    var items = [OMDbItem]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK:- UIViewController methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        showLoadingIndicator()
        APIClient.getMoviesList(searchTerm: currentSearchTerm) { [weak self] (result) in
            self?.hideLoadingIndicator()
            guard let omdbItems = result else {

                if let strongSelf = self {
                    AlertHelper.display(presenter: strongSelf, title: OMSStrings.noResultsFoundTitle, message: OMSStrings.noResultsFoundMessage, dismissCompletion: { [weak self] (action) in
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
                return

            }
            self?.items = omdbItems
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsVC = segue.destination as? MovieDetailViewController, let id = sender as? String {
            movieDetailsVC.itemId = id
        }
    }

}

//MARK:- TableView
extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell
            else {
                return UITableViewCell()
        }
        
        cell.loadDetails(item: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetailSegue", sender: items[indexPath.row].id)
    }
    
}
