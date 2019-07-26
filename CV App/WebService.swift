//
//  WebService.swift
//  CV App
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

class WebService {

    let baseURL = "https://www.mocky.io/v2/5d38e8e39f0000344e9b414b"   // Host address
    var chachedURL : URL?                                              // For testing purpose
    
    var session: URLSession!
    static let sharedInstance = WebService()
    
    func getBiodata(completion: @escaping (_ candidateDetail:[Biodata]?, _ error: Error?) -> Void) {
        
        getJSONFromURL(urlString: baseURL) { (data, error) in
            
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return completion(nil, error)
            }
            
            do {                                // Here dataResponse is received from a network request
                let decoder = JSONDecoder()
                let models = try decoder.decode(Array<Biodata>.self, from:dataResponse) //Decode JSON Response Data
                return completion(models, nil)
            } catch let parsingError {
                print("Failed to convert data\(parsingError)")
                return completion(nil, error)
            }
        }
    }
    
    
    func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        self.chachedURL = url
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in     // URL request sent on data task
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
            completion(responseData, nil)
        }
        task.resume()
    }
}

