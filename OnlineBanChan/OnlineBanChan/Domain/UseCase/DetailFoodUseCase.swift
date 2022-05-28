//
//  DetailFoodUseCase.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import Foundation
import RxSwift

protocol DetailFoodUseCase {
    func fetchDetail() -> Observable<[Detail]>
    func fetchImages() -> Observable<[Data]>
}

class DefaultDetailFoodUseCase: DetailFoodUseCase {
    
    private let banchanRepository: BanChanRepository
    private let foodImageRepository: FoodImagesRepository

    init(banchanRepository: BanChanRepository,
         foodImageRepository: FoodImagesRepository) {
        self.banchanRepository = banchanRepository
        self.foodImageRepository = foodImageRepository
    }
    
    func fetchDetail() -> Observable<[MainSection]> {
        <#code#>
    }
    
    func fetchImages() -> Observable<[Data]> {
        <#code#>
    }
    
}
