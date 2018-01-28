//
//  APIClient.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 24/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import Foundation

class APIClient {
    
    static func getMoviesList(searchTerm: String, completion: @escaping (_ result: [OMDbItem]?) -> Void) {
        
        Networking.callAPI(path: .search(searchTerm: searchTerm)) { (Result) in
            switch Result {
            case .success(let responseData):
                let items: Root? = decode(data: responseData)
                completion(items?.Search)
            case .error(_):
                completion(nil)
            }
        }
        
    }
    
    static func getMovieDetails(id: String, completion: @escaping (_ result: OMDbItem?) -> Void) {
        
        Networking.callAPI(path: .detail(id: id)) { (Result) in
            switch Result {
            case .success(let responseData):
                let searchResult: OMDbItem? = decode(data: responseData)
                completion(searchResult)
            case .error(_):
                completion(nil)
            }
        }
        
    }
    
    
    // Generic function to decode Movie list and Movie Model
    static func decode<T: Codable>(data: Data) -> T? {
        
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T.self, from: data)
        return result
        
    }
    
}

