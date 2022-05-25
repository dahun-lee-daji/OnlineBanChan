//
//  DefaultFoodImagesRepository.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation
import RxSwift

class DefaultFoodImagesRepository: FoodImagesRepository {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchFoodImage(with url: String) -> Observable<Data> {
        return networkService.request(with: url)
            .compactMap({ $0})
        
    }
    
}
