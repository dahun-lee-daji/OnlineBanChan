//
//  MainViewFlowCoordinator.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit

protocol MainFoodViewFlowCoordinatorDependencies  {
    func makeMainFoodViewController(actions: MainFoodViewModelActions) -> MainFoodViewController
    func makeDetailFoodViewController(actions: DetailFoodViewModelActions, detailHash: String) -> DetailFoodViewController
}

class MainFoodViewFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MainFoodViewFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: MainFoodViewFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = MainFoodViewModelActions.init(pushFoodDetailView: pushFoodDetailView)
        let vc = dependencies.makeMainFoodViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func pushFoodDetailView(hashId: String) {
        let actions = DetailFoodViewModelActions.init()
        let vc = dependencies.makeDetailFoodViewController(actions: actions, detailHash: hashId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
