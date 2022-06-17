//
//  MainViewFlowCoordinator.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit

protocol MainFoodViewFlowCoordinatorDependencies  {
    func makeMainFoodViewController(actions: MainFoodViewModelActions) -> MainFoodViewController
    func makeDetailFoodViewController(actions: DetailFoodViewModelActions, prepare: DetailPreparation) -> DetailFoodViewController
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
        let actions = MainFoodViewModelActions.init(pushFoodDetailView: pushFoodDetailView, showToast: showToast)
        let vc = dependencies.makeMainFoodViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func pushFoodDetailView(prepare: DetailPreparation) {
        let actions = DetailFoodViewModelActions.init(presentAlert: presentAlert)
        let vc = dependencies.makeDetailFoodViewController(actions: actions, prepare: prepare)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentAlert(bool: Bool) {
        let title = bool ? "성공" : "실패"
        let message = bool ? "주문 완료!" :
        """
주문 실패!
수량이 부족해요!
"""
        
        let okAction = UIAlertAction.init(title: "알겠어요!", style: .default)
        let alert = UIAlertController
            .init(title: title,
                  message: message,
                  preferredStyle: .alert)
        alert.addAction(okAction)
        
        navigationController?.present(alert, animated: true)
    }
    
    private func showToast(text: String) {
        guard let navigationController = navigationController else {
            return
        }

        Toaster.shared.showUpWith(text: text, to: navigationController.view)
    }
    
}
