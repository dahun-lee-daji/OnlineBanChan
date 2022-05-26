//
//  MainFoodViewModel.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation
import RxSwift

struct MainFoodViewModelActions {
    
}

protocol MainFoodViewModelInput {
}

protocol MainFoodViewModelOutput {
}

protocol MainFoodViewModel: MainFoodViewModelInput, MainFoodViewModelOutput {}

class DefaultMainFoodViewModel: MainFoodViewModel {
    
    private let mainFoodUseCase: MainFoodUseCase
    private let actions: MainFoodViewModelActions?
    
    // MARK: - OUTPUT

    // MARK: - Init

    init(mainFoodUseCase: MainFoodUseCase,
         actions: MainFoodViewModelActions? = nil) {
        self.mainFoodUseCase = mainFoodUseCase
        self.actions = actions
    }
}

// MARK: - INPUT. View event methods

extension DefaultMainFoodViewModel {
    
}
