//
//  APIClient.swift
//  OMDb Movie Search
//
//  Created by Rajeev Bhatia on 24/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    static private let apiKey = "16272669"
    
    static func getMoviesList(searchTerm: String, completion: @escaping (_ result: [OMDbItem]?) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=\(APIClient.apiKey)&s=\(searchTerm)"
        
        Alamofire.request(urlString).responseData { response in
            
            guard let responseData = response.data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            let searchResult = try? decoder.decode(Root.self, from: responseData)
            
            guard let items = searchResult?.Search else { return }
            
            completion(items)
            
        }
    }
    
}
