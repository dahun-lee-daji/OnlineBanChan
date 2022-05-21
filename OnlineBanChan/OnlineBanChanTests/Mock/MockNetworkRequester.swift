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
    
    func get<T>(endPoint: EndPoint, session: Session) -> Observable<T> where T : Decodable, T : Encodable {
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
    
    
}

//    class MockNetworkService: NetworkRequesting {
//        func get<T: Codable>(endPoint: EndPoint, session: Session) -> Observable<T> {
//
//            return Observable.create({ observer in
//
//                guard let url : URLConvertible = try? endPoint.asURL() else {
//                    observer.onError(NetworkErrors.invalidURL)
//                    return Disposables.create()
//                }
//
//                let dataRequester = session.request(url)
//
//                dataRequester
//                    .response(completionHandler: { response in
//                        switch response.result {
//                        case .success(let data):
//                            observer.onNext(data)
//                        case .failure(let error):
//                            observer.onError(error)
//                        }
//                        observer.onCompleted()
//                    })
//
//                return Disposables.create {
//                    dataRequester.cancel()
//                }
//            })
//        }
//
//
//
//    }
