//
//  WholeResponse.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation

struct WholeResponse: Codable {
    let statusCode: Int
    let body: [MainSection]
}

extension WholeResponse: Equatable {
    static func == (lhs: WholeResponse, rhs: WholeResponse) -> Bool {
        lhs.statusCode == rhs.statusCode &&
        lhs.body == rhs.body
    }
}
