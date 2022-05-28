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
    
    func fetchDishList() -> Observable<[MainSection]> {
        let endPoint = APIEndPoint.getSectionsEndPoint()
        let wholeReponse: Observable<MainSectionsDTO> = networkService.request(with: endPoint)
            
        return wholeReponse.map({
            $0.body
        })
    }
    
}
