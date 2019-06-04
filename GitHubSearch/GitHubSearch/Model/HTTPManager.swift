//
//  HTTPManager.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/3.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation

class HTTPManager {
    
    static let shared = HTTPManager()
    
    private init () {}
    
    private func makeRequest(_ ghRequest:GHRequest) -> URLRequest {
        
        let urlString = Bundle.GHValueForString(key: GHConstant.urlKey) + ghRequest.endPoint
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = ghRequest.headers
        
        request.httpMethod = ghRequest.method
        
        return request
    }

    func request(
        _ ghRequest: GHRequest, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: makeRequest(ghRequest)) { (data, resp, err) in
            
            guard err != nil else {
                completion(.failure(err!))
                return
            }
            
            do {
                let userModel = try JSONDecoder().decode(UserModel.self, from: data!)
                
                completion(.success(userModel))
                
            } catch let jsonError {
                
                completion(.failure(jsonError))
                
            }
            
        }.resume()
            
    }
}
