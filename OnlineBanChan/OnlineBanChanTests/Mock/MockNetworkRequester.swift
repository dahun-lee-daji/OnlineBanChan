//
//  MockNetworkRequester.swift
//  OnlineBanChanTests
//
//  Created by 이다훈 on 2022/05/21.
//

import Foundation
import Alamofire
import RxSwift
@testable import OnlineBanChan

struct MockNetworkRequester: NetworkRequesting {
    
    enum MockNetworkError: Error {
        case optionalBindingError
        case parsingError
    }
    
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func get<T>(url: URLConvertible, session: Session) -> Observable<T> where T : Decodable, T : Encodable {
        return Observable.create({ observer in
            
            sleep(1)
            
            if let error = error {
                observer.onError(error)
            }
            
            let decoder = JSONDecoder()
            guard let data = data else {
                observer.onError(MockNetworkError.optionalBindingError)
                return Disposables.create()
            }
            
            guard let json =  try? decoder.decode(T.self, from: data) else {
                observer.onError(MockNetworkError.parsingError)
                return Disposables.create()
            }
            
            observer.onNext(json)
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
    
    func getWithoutDecode(url: URLConvertible, session: Session) -> Observable<Data?> {
        return Observable.just(data)
    }
    
}
