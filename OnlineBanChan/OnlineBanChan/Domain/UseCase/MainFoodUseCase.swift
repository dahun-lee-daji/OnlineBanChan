//
//  MainFoodUseCase.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation
import RxSwift

protocol MainFoodUseCase {
    func fetchMainSections() -> Observable<[MainSection]>
}

class DefaultMainFoodUseCase: MainFoodUseCase {
    
    private let banchanRepository: BanChanRepository
    private let foodImageRepository: FoodImagesRepository

    init(banchanRepository: BanChanRepository,
         foodImageRepository: FoodImagesRepository) {
        self.banchanRepository = banchanRepository
        self.foodImageRepository = foodImageRepository
    }
    
    func fetchMainSections() -> Observable<[MainSection]> {
        banchanRepository.fetchDishList()
    }
    
}
