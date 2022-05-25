//
//  EndPoint.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation
import Alamofire

struct EndPoint: URLConvertible {
    
    let scheme: String
    let host: String
    let path: String
    let method: HTTPMethod
    
    init(scheme: String,
         host: String,
         apiPath: String,
         httpMethod: HTTPMethod) {
        
        self.scheme = scheme
        self.host = host
        self.path = apiPath
        self.method = httpMethod
    }
    
    func asURL() throws -> URL {
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        guard let url = component.url else {
            throw NetworkErrors.invalidURL
        }
        
        return url
    }
    
    
}
