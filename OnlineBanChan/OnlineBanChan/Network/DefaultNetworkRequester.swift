//
//  NetworkRequester.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation
import Alamofire
import RxSwift

protocol NetworkRequesting {
    func get<T: Codable>(url: URLConvertible, session: Session) -> Observable<T>
    func getWithoutDecode(url: URLConvertible, session: Session) -> Observable<Data?>
}

class DefaultNetworkRequester: NetworkRequesting {
    
    func get<T: Codable>(url: URLConvertible, session: Session) -> Observable<T> {
        
        return Observable.create({ observer in
            
            let dataRequester = session.request(url)
            
            dataRequester
                .validate()
                .responseDecodable(of: T.self,
                                   queue: .global(),
                                   completionHandler: { response in

                    switch response.result {
                    case .success(let data) :
                        observer.onNext(data)
                    case .failure(let error) :
                        observer.onError(error)
                    }
                    observer.onCompleted()
                })
                
                
            
            return Disposables.create {
                
                dataRequester.cancel()
            }
        })
    }

    func getWithoutDecode(url: URLConvertible, session: Session) -> Observable<Data?> {
        return Observable.create({ observer in
            let dataRequester = session.request(url)
            
            dataRequester
                .validate()
                .response(completionHandler: {
                    response in
                    
                    switch response.result {
                    case .success(let data) :
                        observer.onNext(data)
                    case .failure(let error) :
                        observer.onError(error)
                    }
                    observer.onCompleted()
                })
                
            return Disposables.create {
                
                dataRequester.cancel()
            }
        })
    }
}
