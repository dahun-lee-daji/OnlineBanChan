//
//  WholeResponse.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation

struct MainSectionsDTO: Codable {
    let statusCode: Int
    let body: [MainSection]
}

extension MainSectionsDTO: Equatable {
    static func == (lhs: MainSectionsDTO, rhs: MainSectionsDTO) -> Bool {
        lhs.statusCode == rhs.statusCode &&
        lhs.body == rhs.body
    }
}
