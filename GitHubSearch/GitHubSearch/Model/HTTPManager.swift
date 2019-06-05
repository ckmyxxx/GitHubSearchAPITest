//
//  HTTPManager.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/3.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation

enum GHHTTPManagerError: Error {
    
    case clientError(Data)
    
    case serverError
    
    case unexpectedError
}

class HTTPManager {
    
    static let shared = HTTPManager()
    
    private init () {}
    
    private func makeRequest(_ ghRequest:GHRequest) -> URLRequest {
        
        let urlString = Bundle.GHValueForString(key: GHConstant.urlKey) + ghRequest.endPoint
        
        let urlComponents = NSURLComponents(string: urlString)!

        urlComponents.queryItems = ghRequest.para
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.allHTTPHeaderFields = ghRequest.headers
        
        request.httpMethod = ghRequest.method
        
        return request
    }
    
    func request(
        _ ghRequest: GHRequest, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: makeRequest(ghRequest)) { (data, resp, err) in
            
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            let httpResponse = resp as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            switch statusCode {
                
            case 200..<300:
                
                do {
                    var userModel = try JSONDecoder().decode(UserModel.self, from: data!)
                    
                    if let next = httpResponse.allHeaderFields["Link"] as? String, next.checkNextPage() {
                        userModel.next = true
                    } else {
                        userModel.next = false
                    }
                    completion(.success(userModel))
                    
                } catch let jsonError {
                    
                    completion(.failure(jsonError))
                    
                }
                
            case 400..<500:
                
                completion(Result.failure(GHHTTPManagerError.clientError(data!)))
                
            case 500..<600:
                
                completion(Result.failure(GHHTTPManagerError.serverError))
                
            default: return
                
                completion(Result.failure(GHHTTPManagerError.unexpectedError))
            }
            
        }.resume()
            
    }
}
