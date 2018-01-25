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
    
    var items = [OMDbItem]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
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
            self?.items = omdbItems
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsVC = segue.destination as? MovieDetailViewController, let id = sender as? String {
            movieDetailsVC.itemId = id
        }
    }

}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell
            else {
                return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        
        cell.imgView.sd_setImage(with: URL(string: item.posterUrlString ?? "http://baltimoresportsandlife.com/wp-content/uploads/2016/07/Movies.jpg")) { (image, error, cacheType, url) in
            cell.setNeedsLayout()
        }
        
        cell.nameLabel.text = item.title
        cell.typeLabel.text = item.type
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetailSegue", sender: items[indexPath.row].id)
    }
    
}
