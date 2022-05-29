//
//  DetailFoodUseCase.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import Foundation
import RxSwift

protocol DetailFoodUseCase {
    func fetchDetail() -> Observable<FoodDetail>
    func fetchFoodImage(imageString: String) -> Observable<Data>
}

class DefaultDetailFoodUseCase: DetailFoodUseCase {
    
    private let banchanRepository: BanChanRepository
    private let foodImageRepository: FoodImagesRepository
    private let detailHash: String

    init(banchanRepository: BanChanRepository,
         foodImageRepository: FoodImagesRepository,
         detailHash: String) {
        self.banchanRepository = banchanRepository
        self.foodImageRepository = foodImageRepository
        self.detailHash = detailHash
    }
    
    func fetchDetail() -> Observable<FoodDetail> {
        banchanRepository.fetchFoodDetail(hashId: detailHash)
    }
    
    func fetchFoodImage(imageString: String) -> Observable<Data> {
        foodImageRepository.fetchFoodImage(with: imageString)
    }
    
}
