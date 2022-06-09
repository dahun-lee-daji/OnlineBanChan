//
//  FoodDetail.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import Foundation

struct FoodDetailDTO: Codable {
    let hash: String
    let data: FoodDetail
}

struct FoodDetail: Codable {
    let topImage: String
    let thumbnails: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailImages: [String]
    
    init() {
        self.topImage = ""
        self.thumbnails = []
        self.productDescription = ""
        self.point = ""
        self.deliveryInfo = ""
        self.deliveryFee = ""
        self.prices = []
        self.detailImages = []
    }
}

extension FoodDetail {
    enum CodingKeys: String, CodingKey {
        case point,prices
        case topImage = "top_image"
        case thumbnails = "thumb_images"
        case productDescription = "product_description"
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case detailImages = "detail_section"
    }
}
