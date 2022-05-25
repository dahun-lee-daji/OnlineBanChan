//
//  FoodImagesRepository.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation
import RxSwift

protocol FoodImagesRepository: Repository {
    func fetchFoodImage(with urlString: String) -> Observable<Data>
}
