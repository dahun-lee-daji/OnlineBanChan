//
//  SceneDIContainer.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation

class SceneDIContainer {
    
    struct Dependencies {
        let apiNetworkService: NetworkService
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Repositories
    func makeBanChanRepository() -> BanChanRepository {
        return DefaultBanChanRepository(networkService: dependencies.apiNetworkService)
    }
    
    func makeFoodImagesRepository() -> FoodImagesRepository {
        return DefaultFoodImagesRepository(networkService: dependencies.apiNetworkService)
    }
}
