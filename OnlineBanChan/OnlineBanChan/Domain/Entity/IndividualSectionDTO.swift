//
//  IndividualSectionDTO.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/06/22.
//

import Foundation

struct IndividualSectionDTO: Codable {
    let statusCode: Int
    let body: [SectionCardItem]
}
