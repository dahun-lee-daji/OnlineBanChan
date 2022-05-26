//
//  MainViewFlowCoordinator.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit

protocol MainFoodViewFlowCoordinatorDependencies  {
    func makeMainFoodViewController(actions: MainFoodViewModelActions) -> MainFoodViewController
}

class MainFoodViewFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MainFoodViewFlowCoordinatorDependencies

    private weak var mainFoodVC: MainFoodViewController?

    init(navigationController: UINavigationController,
         dependencies: MainFoodViewFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = MainFoodViewModelActions.init()
        let vc = dependencies.makeMainFoodViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        mainFoodVC = vc
    }
}
