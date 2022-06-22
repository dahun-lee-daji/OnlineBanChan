//
//  MainFoodUseCase.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation
import RxSwift

protocol MainFoodUseCase {
    func fetchBestSections() -> Observable<[MainSection]>
    func fetchIndividualSection(api: APIEndPoint.APIPath) -> Observable<[MainSection]>
    func fetchFoodImage(imageString: String) -> Observable<Data>
}

class DefaultMainFoodUseCase: MainFoodUseCase {
    
    private let banchanRepository: BanChanRepository
    private let foodImageRepository: FoodImagesRepository

    init(banchanRepository: BanChanRepository,
         foodImageRepository: FoodImagesRepository) {
        self.banchanRepository = banchanRepository
        self.foodImageRepository = foodImageRepository
    }
    
    func fetchBestSections() -> Observable<[MainSection]> {
        banchanRepository.fetchBestSection()
    }
    
    func fetchFoodImage(imageString: String) -> Observable<Data> {
        foodImageRepository.fetchFoodImage(with: imageString)
    }
    
    func fetchIndividualSection(api: APIEndPoint.APIPath) -> Observable<[MainSection]> {
        banchanRepository.fetchIndividualSection(api: api)
    }
    
}
