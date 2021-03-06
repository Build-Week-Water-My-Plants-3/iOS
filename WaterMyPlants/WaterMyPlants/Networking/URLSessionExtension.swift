//
//  URLSessionExtension.swift
//  WaterMyPlants
//
//  Created by Craig Swanson on 3/4/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {
    func loadData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let loadDataTask = dataTask(with: request) { possibleData, possibleResponse, possibleError in
            
            if let error = possibleError {
                completion(nil, nil, error)
            }
            
            if let response = possibleResponse as? HTTPURLResponse,
            response.statusCode != 200 {
                completion(nil, response, nil)
            }
            
            guard let data = possibleData else {
                completion(nil, nil, possibleError)
                return
            }
            completion(data, nil, nil)
        }
        loadDataTask.resume()
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let loadDataTask = dataTask(with: url) { possibleData, _, possibleError in
            completion(possibleData, possibleError)
        }
        loadDataTask.resume()
    }
}
