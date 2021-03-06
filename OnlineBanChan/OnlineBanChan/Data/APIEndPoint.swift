//
//  APIEndPoint.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/25.
//

import Foundation


struct APIEndPoint {
    
    enum SchemeType: String {
        case https = "https"
        case http = "http"
    }

    enum HostType: String {
        case dishDataHost = "h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com"
        case imageHost = "public.codesquad.kr/jk/storeapp/data"
    }

    enum APIPath: String {
        case sections = "/develop/baminchan/best"
        case detail = "/develop/baminchan/detail/"
        case main = "/develop/baminchan/main"
        case side = "/develop/baminchan/side"
        case soup = "/develop/baminchan/soup"
    }
    
    static func getSectionsEndPoint(api: APIPath) -> EndPoint {
        return EndPoint.init(scheme: SchemeType.https.rawValue,
                             host: HostType.dishDataHost.rawValue,
                             apiPath: api.rawValue,
                             httpMethod: .get)
    }
    
    static func getFoodDetailEndPoint(hash: String) -> EndPoint {
        return EndPoint.init(scheme: SchemeType.https.rawValue,
                             host: HostType.dishDataHost.rawValue,
                             apiPath: APIPath.detail.rawValue + hash,
                             httpMethod: .get)
    }
}
