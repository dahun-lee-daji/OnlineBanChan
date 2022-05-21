//
//  EndPoint.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation
import Alamofire

enum NetworkErrors: Error {
    case invalidURL
}

enum APIPath: String {
    case sections = "develop/baminchan/best"
}

struct EndPoint: URLConvertible {
    
    let scheme: String
    let host: String
    let path: APIPath
    let method: HTTPMethod
    
    init(scheme: String = "https",
         host: String = "h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com",
         apiPath: APIPath,
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
        component.path = "/\(path.rawValue)"
        guard let url = component.url else {
            throw NetworkErrors.invalidURL
        }
        
        return url
    }
    
    
}
