//
//  NetworkService.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation
import RxSwift
import Alamofire

class NetworkService {
    
    let networkRequester: NetworkRequesting
    
    init(requester: NetworkRequesting = NetworkRequester.init()) {
        self.networkRequester = requester
    }
    
    func getSections() -> Observable<WholeResponse> {
        let endPoint = EndPoint.init(apiPath: .sections, httpMethod: .get)
        return networkRequester.get(endPoint: endPoint, session: AF)
    }
}
