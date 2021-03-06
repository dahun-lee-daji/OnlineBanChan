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
        let toaster: Toaster
        let imageCacher: ImageCacher
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
        return DefaultFoodImagesRepository(networkService: dependencies.apiNetworkService, imageCacher: dependencies.imageCacher)
    }
    
    // MARK: - FlowCoordinator
    
    func makeMainFoodViewFlowCoordinator(navigationController: UINavigationController) -> MainFoodViewFlowCoordinator {
        return MainFoodViewFlowCoordinator
            .init(navigationController: navigationController,
                  dependencies: self,
                  toaster: dependencies.toaster)
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
    
    // MARK: - DetailFoodView
    
    func makeDetailFoodUseCase(detailHash: String) -> DetailFoodUseCase {
        return DefaultDetailFoodUseCase
            .init(banchanRepository: makeBanChanRepository(),
                  foodImageRepository: makeFoodImagesRepository(),
                  detailHash: detailHash)
        }
    
    func makeDetailFoodViewModel(action: DetailFoodViewModelActions, prepare: DetailPreparation) -> DetailFoodViewModel {
        return DefaultDetailFoodViewModel
            .init(
                detailFoodUseCase: makeDetailFoodUseCase(detailHash: prepare.hashId),
                actions: action,
                prepare: prepare
            )
    }
    
    func makeDetailFoodViewController(actions: DetailFoodViewModelActions, prepare: DetailPreparation) -> DetailFoodViewController {
        return  DetailFoodViewController
            .create(with:
                        makeDetailFoodViewModel(action: actions,
                                                prepare: prepare)
            )
    }
}

extension SceneDIContainer: MainFoodViewFlowCoordinatorDependencies {}
