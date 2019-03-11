//
//  RTBaseService.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

class RTBaseService {
    
    static func request<T: Codable>(model: T.Type, method: HTTPMethod, service: RTService, parameters: [String: String]? = nil, body: Data? = nil, headers: [String: String]? = nil, completion: @escaping (RTResult<T>)->()) {
        
        guard let request = self.buildRequest(service: service, method: method, parameters: parameters, body: body, headers: headers) else {
            completion(.error(RTError.defaultError))
            return
        }
        
        RTBaseService.showNetworkActivityIndicator(true)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            RTBaseService.showNetworkActivityIndicator(false)
            
            if let error = error {
                completion(.error(error))
                return
            }
            
            if let parsedResponse: T = self.parseData(data: data, model: model) {
                completion(.success(parsedResponse))
            } else {
                completion(.error(RTError.codableError))
            }
        }
        
        task.resume()
    }
    
    private static func buildRequest(service: RTService, method: HTTPMethod, parameters: [String: String]? = nil, body: Data? = nil, headers: [String: String]? = nil) -> URLRequest? {
        
        guard var urlComponents = URLComponents(string: service.url()) else { return nil }
        
        if let parameters = parameters, !parameters.isEmpty {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        
        if let headers = headers, !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return request
    }
    
    private static func parseData<T: Codable> (data: Data?, model: T.Type) -> T? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
    
    private static func showNetworkActivityIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
    }
    
    enum RTResult<T> {
        case success(T)
        case error(Error)
    }
    
    enum RTError: Error {
        case codableError
        case defaultError
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
}

