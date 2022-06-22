//
//  MainSections.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation
import RxDataSources

struct MainSection: Codable {
    let categoryId: String
    let name: String
    var items: [SectionCardItem]
    var type: APIEndPoint.APIPath?
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

extension MainSection: IdentifiableType {
    var identity: String {
        return categoryId
    }
}

extension MainSection: AnimatableSectionModelType {
    init(original: MainSection, items: [SectionCardItem]) {
        self = original
        self.items = items
    }
}
