//
//  SectionCardItem.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/20.
//

import Foundation
import RxDataSources

struct SectionCardItem: Codable {
    let detailHashId: String
    let imageString: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let itemDescription: String
    let priceToSale: String
    let priceOfNormal: String?
    let badge: [String]?
}

extension SectionCardItem {
    enum CodingKeys: String, CodingKey {
        case alt, title, badge
        case detailHashId = "detail_hash"
        case imageString = "image"
        case deliveryType = "delivery_type"
        case itemDescription = "description"
        case priceToSale = "s_price"
        case priceOfNormal = "n_price"
    }
}

extension SectionCardItem: IdentifiableType {
    var identity: String {
        return detailHashId
    }
}

extension SectionCardItem: Hashable {}
