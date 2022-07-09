//
//  AppDIContainer.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation

class AppDIContainer {
    
    lazy private var apiNetworkService = DefaultNetworkService()
    lazy private var toaster = Toaster()
    lazy private var imageCacher = ImageCacher.shared
    
    func makeSceneDIContainer() -> SceneDIContainer {
        let dependencies = SceneDIContainer
            .Dependencies(apiNetworkService: apiNetworkService,
                          toaster: toaster,
                          imageCacher: imageCacher)
        return SceneDIContainer(dependencies: dependencies)
    }
}
