//
//  Networking.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 28/01/2018.
//  Copyright © 2018 rajeev. All rights reserved.
//

import Foundation

enum Result {
    case success(Data)
    case error(error)
}

enum error: Error {
    case invalidURL
    case noResponse
}

enum Path {
    case search(searchTerm :String)
    case detail(id: String)
    
    public var endPoint: String {
        switch self {
        case .search(let searchTerm):
            return "&s=\(searchTerm)"
        case .detail(let id):
            return "&i=\(id)&plot=full"
        }
    }
}

class Networking {
    
    private static let apiKey = "apikey=16272669"
    private static let BaseURL = "http://www.omdbapi.com/?"
    private static let config = URLSessionConfiguration.default
    
    private static func createRequestURL(path: Path) -> URL? {
        let urlString = BaseURL + apiKey + path.endPoint
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    static func callAPI(path: Path, completion: @escaping (_ result: Result) -> Void) {
        guard let url = createRequestURL(path: path) else {
            completion(Result.error(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let responseData = data else {
                completion(Result.error(.noResponse))
                return
            }
            completion(Result.success(responseData))
        }
        task.resume()
    }
    
}


