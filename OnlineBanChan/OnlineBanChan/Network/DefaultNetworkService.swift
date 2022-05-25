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
    case invalidURL
}

protocol NetworkService {
    func request<T: Codable>(with endPoint: URLConvertible) -> Observable<T>
}

class DefaultNetworkService : NetworkService {
    
    let networkRequester: NetworkRequesting
    
    init(requester: NetworkRequesting = DefaultNetworkRequester.init()) {
        self.networkRequester = requester
    }
    
    func request<T: Codable>(with endPoint: URLConvertible) -> Observable<T> {
        guard let url : URLConvertible = try? endPoint.asURL() else {
            return Observable.error(NetworkErrors.invalidURL)
        }
        return networkRequester.get(url: url, session: AF)
    }
}
