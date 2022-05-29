//
//  SceneDIContainer.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit

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
    
    // MARK: - FlowCoordinator
    
    func makeMainFoodViewFlowCoordinator(navigationController: UINavigationController) -> MainFoodViewFlowCoordinator {
        return MainFoodViewFlowCoordinator.init(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - MainFoodView
    
    func makeMainFoodUseCase() -> MainFoodUseCase {
        return DefaultMainFoodUseCase.init(banchanRepository: makeBanChanRepository(), foodImageRepository: makeFoodImagesRepository())
        }
    
    func makeMainFoodViewModel(action: MainFoodViewModelActions) -> MainFoodViewModel {
        return DefaultMainFoodViewModel.init(mainFoodUseCase: makeMainFoodUseCase(), actions: action)
    }
    
    func makeMainFoodViewController(actions: MainFoodViewModelActions) -> MainFoodViewController {
        return  MainFoodViewController
            .create(with: makeMainFoodViewModel(action: actions))
    }
    
    // MARK: - MainFoodView
    
    func makeDetailFoodUseCase(detailHash: String) -> DetailFoodUseCase {
        return DefaultDetailFoodUseCase
            .init(banchanRepository: makeBanChanRepository(),
                  foodImageRepository: makeFoodImagesRepository(),
                  detailHash: detailHash)
        }
    
    func makeDetailFoodViewModel(action: DetailFoodViewModelActions, detailHash: String) -> DetailFoodViewModel {
        return DefaultDetailFoodViewModel
            .init(detailFoodUseCase: makeDetailFoodUseCase(detailHash: detailHash),
                  actions: action)
    }
    
    func makeDetailFoodViewController(actions: DetailFoodViewModelActions, detailHash: String) -> DetailFoodViewController {
        return  DetailFoodViewController
            .create(with:
                        makeDetailFoodViewModel(action: actions,
                                               detailHash: detailHash)
            )
    }
}

extension SceneDIContainer: MainFoodViewFlowCoordinatorDependencies {}
