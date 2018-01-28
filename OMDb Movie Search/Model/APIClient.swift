//
//  APIClient.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 24/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import Foundation

class APIClient {
    
    static private let apiKey = "16272669"
    
    static func getMoviesList(searchTerm: String, completion: @escaping (_ result: [OMDbItem]?) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=\(APIClient.apiKey)&s=\(searchTerm)"
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
        
            guard let responseData = data else {
                completion(nil)
                return
            }
            
            let items = decodeMoviesList(data: responseData)
            
            completion(items)
            
        }
        
        task.resume()
    }
    
    static func decodeMoviesList(data: Data) -> [OMDbItem]? {
        let decoder = JSONDecoder()
        let searchResult = try? decoder.decode(Root.self, from: data)
        
        return searchResult?.Search
    }
    
    static func getMovieDetails(id: String, completion: @escaping (_ result: OMDbItem?) -> Void) {
        
        let urlString = "http://www.omdbapi.com/?apikey=\(APIClient.apiKey)&i=\(id)&plot=full"
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(nil)
                return
            }
            
            let searchResult = decodeMovie(data: responseData)
            
            completion(searchResult)
            
        }
        task.resume()
        
    }
    
    static func decodeMovie(data: Data) -> OMDbItem? {
        let decoder = JSONDecoder()
        let searchResult = try? decoder.decode(OMDbItem.self, from: data)
        return searchResult
    }
    
}
