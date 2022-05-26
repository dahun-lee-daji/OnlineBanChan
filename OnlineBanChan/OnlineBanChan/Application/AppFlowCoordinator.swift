//
//  AppFlowCoordinator.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit

class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let sceneDIContainer = appDIContainer.makeSceneDIContainer()
        let flowCoordinator = sceneDIContainer.makeMainFoodViewFlowCoordinator(navigationController: navigationController)
        flowCoordinator.start()
    }
}
