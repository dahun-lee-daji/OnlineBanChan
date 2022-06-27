//
//  DefaultBanChanRepository.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/25.
//

import Foundation
import RxSwift

class DefaultBanChanRepository: BanChanRepository {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private enum IndividualSectionName: String {
        case main = "든든한 메인요리"
        case soup = "따끈한 국물요리"
        case side = "맛깔스러운 반찬"
    }
    
    func fetchBestSection() -> Observable<[MainSection]> {
        let endPoint = APIEndPoint.getSectionsEndPoint(api: .sections)
        let wholeReponse: Observable<MainSectionsDTO> = networkService.request(with: endPoint)
            
        return wholeReponse.map({ DTO in
            return DTO.body
        })
    }
    
    func fetchIndividualSection(api: APIEndPoint.APIPath) -> Observable<[MainSection]> {
        let endPoint = APIEndPoint.getSectionsEndPoint(api: api)
        let wholeResponse: Observable<IndividualSectionDTO> = networkService.request(with: endPoint)
        var sectionName = ""
        
        switch api {
        case.main:
            sectionName = IndividualSectionName.main.rawValue
        case.soup:
            sectionName = IndividualSectionName.soup.rawValue
        case.side:
            sectionName = IndividualSectionName.side.rawValue
        default:
            sectionName = ""
        }
        
        
        return wholeResponse.map({ DTO in
            return [MainSection.init(categoryId: "\(api.hashValue)",
                             name: sectionName,
                                     items: DTO.body.map({
                var temp = $0
                temp.type = api
                return temp
            })
                                    )]
        })
        
    }
    
    func fetchFoodDetail(hashId: String) -> Observable<FoodDetail> {
        let endPoint = APIEndPoint.getFoodDetailEndPoint(hash: hashId)
        let dto: Observable<FoodDetailDTO> = networkService.request(with: endPoint)
            
        return dto.map({ dto in
            dto.data
        })
    }
    
}
