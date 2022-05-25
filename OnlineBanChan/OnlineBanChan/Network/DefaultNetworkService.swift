//
//  DefaultNetworkService.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation
import RxSwift
import Alamofire

enum NetworkErrors: Error {
    case invalidEndPoint
    case invalidURL
    case optionalBinding
}

protocol NetworkService {
    func request<T: Codable>(with endPoint: URLConvertible) -> Observable<T>
    func request(with urlString: String) -> Observable<Data?>
}

class DefaultNetworkService : NetworkService {
    
    let networkRequester: NetworkRequesting
    
    init(requester: NetworkRequesting = DefaultNetworkRequester.init()) {
        self.networkRequester = requester
    }
    
    func request<T: Codable>(with endPoint: URLConvertible) -> Observable<T> {
        guard let url : URLConvertible = try? endPoint.asURL() else {
            return Observable.error(NetworkErrors.invalidEndPoint)
        }
        return networkRequester.get(url: url, session: AF)
    }
    
    func request(with urlString: String) -> Observable<Data?> {
        guard let url = URL.init(string: urlString) else {
            return Observable.error(NetworkErrors.invalidURL)
        }
        
        return networkRequester.getWithoutDecode(url: url, session: AF)
    }
}
