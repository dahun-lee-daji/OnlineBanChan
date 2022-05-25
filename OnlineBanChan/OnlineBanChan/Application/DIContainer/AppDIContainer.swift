//
//  AppDIContainer.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation

class AppDIContainer {
    
    lazy var apiNetworkService: NetworkService = DefaultNetworkService()
    
    func makeSceneDIContainer() -> SceneDIContainer {
        let dependencies = SceneDIContainer
            .Dependencies(apiNetworkService: apiNetworkService)
        return SceneDIContainer(dependencies: dependencies)
    }
}
