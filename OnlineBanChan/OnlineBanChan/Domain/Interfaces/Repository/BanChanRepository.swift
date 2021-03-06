//
//  BanChanRepository.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/25.
//

import Foundation
import RxSwift

protocol BanChanRepository: Repository {
    func fetchBestSection() -> Observable<[MainSection]>
    func fetchIndividualSection(api: APIEndPoint.APIPath) -> Observable<[MainSection]> 
    func fetchFoodDetail(hashId: String) -> Observable<FoodDetail>
}
