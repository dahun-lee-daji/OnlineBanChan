//
//  BanChanRepository.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/25.
//

import Foundation
import RxSwift

protocol BanChanRepository {
    func fetchDishList() -> Observable<[MainSection]>
}
