//
//  MainSections.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation

struct MainSection: Codable {
    let categoryId: String
    let name: String
    let items: [SectionCardItem]
}

extension MainSection {
    enum CodingKeys: String, CodingKey {
        case name, items
        case categoryId = "category_id"
    }
    
}

extension MainSection: Equatable {
    static func == (lhs: MainSection, rhs: MainSection) -> Bool {
        lhs.categoryId == rhs.categoryId &&
        lhs.name == rhs.name &&
        lhs.items == rhs.items
    }
    
}
