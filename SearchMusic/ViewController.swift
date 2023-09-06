//
//  ViewController.swift
//  SearchMusic
//
//  Created by Елена Крылова on 31.08.2023.
//

import UIKit

class ViewController: UIViewController {

    let networkDataFetcher = NetworkDataFetcher()
    var searchResponse: SearchResponse? = nil
    private var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabelView()
        setupSearchBar()
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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


//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = searchResponse?.results[indexPath.row]
        print("track?.artworkUrl60:", track?.artworkUrl60)
        cell.textLabel?.text = track?.trackName
        return cell
    }
}

//MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=10"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkDataFetcher.fetchTracks(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.searchResponse = searchResponse
                self.table.reloadData()
            }
        })
    }
}
