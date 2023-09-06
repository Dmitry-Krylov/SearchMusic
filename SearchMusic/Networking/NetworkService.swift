//
//  NetworkService.swift
//  SearchMusic
//
//  Created by Елена Крылова on 02.09.2023.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))

            }
        }.resume()
    }
}
