//
//  ViewController.swift
//  SearchMusic
//
//  Created by Елена Крылова on 31.08.2023.
//

import UIKit

class ViewController: UIViewController {

    let networkService = NetworkService()
    
    @IBOutlet weak var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabelView()
        setupSearchBar()
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=5"
//        request(urlString: urlString) { (searchResponse, error) in
//            searchResponse?.results.map({ (track) in
//                print(track.trackName)
//            })
//        }
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let searchResponse):
                searchResponse.results.map { (track) in
                    print("track.trackName:", track.trackName)
                }
            case .failure(let error):
                print("error", error)
            }
        }
    }


    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    private func setupTabelView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hola"
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
