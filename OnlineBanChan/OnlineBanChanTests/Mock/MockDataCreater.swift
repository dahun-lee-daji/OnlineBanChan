//
//  MockDataCreater.swift
//  OnlineBanChanTests
//
//  Created by 이다훈 on 2022/05/21.
//

import Foundation

@testable import OnlineBanChan

struct MockDataCreater {
    
    let testWholeResponse: WholeResponse
    let testMainSection: MainSection
    let testSectionCardItem: SectionCardItem
    
    /// 기초 설정을 넣어놓은 instance를 반환
    init() {
        let testSectionCardItemValue =
        SectionCardItem.init(detailHashId: "test 상세 해쉬 아이디",
                             imageString: "test 이미지",
                              alt: "test Alt",
                              deliveryType: ["test 배송"],
                              title: "test 제목",
                              itemDescription: "test 설명",
                              price: "test 가격",
                              discountPrice: "test 할인가",
                              badge: ["test 뱃지"])
        
        let testMainSectionsValue =
        MainSection.init(categoryId: "test 카테고리 아이디",
                          name: "test 이름",
                          items: [testSectionCardItemValue])
        
        let testWholeResponseValue =
        WholeResponse.init(statusCode: 200,
                           body: [testMainSectionsValue])
        
        self.testWholeResponse = testWholeResponseValue
        self.testMainSection = testMainSectionsValue
        self.testSectionCardItem = testSectionCardItemValue
    }
    
    func makeWholeResponseData() -> Data {
        makeData(with: testWholeResponse)
    }
    
    private func makeData<T: Codable>(with target: T) -> Data {
        let data = try! JSONEncoder().encode(target)
        return data
    }
}
