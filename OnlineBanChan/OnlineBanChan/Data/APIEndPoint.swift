//
//  APIEndPoint.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/25.
//

import Foundation

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
}

struct APIEndPoint {
    
    static func getSectionsEndPoint() -> EndPoint {
        return EndPoint.init(scheme: SchemeType.https.rawValue,
                             host: HostType.dishDataHost.rawValue,
                             apiPath: APIPath.sections.rawValue,
                             httpMethod: .get)
    }
    
}
//http://public.codesquad.kr/jk/storeapp/data/main/675_ZIP_P_0057_T.jpg
//http://public.codesquad.kr/jk/storeapp/data/side/84_ZIP_P_6006_T.jpg
