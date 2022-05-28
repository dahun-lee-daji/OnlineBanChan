//
//  DetailFoodViewModel.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import Foundation

struct DetailFoodViewModelActions {
    
}

protocol DetailFoodViewModelInput {
}

protocol DetailFoodViewModelOutput {
    
}

protocol DetailFoodViewModel: DetailFoodViewModelInput, DetailFoodViewModelOutput {}

class DefaultDetailFoodViewModel: DetailFoodViewModel {
    
    private let detailFoodUseCase: DetailFoodUseCase
    private let actions: DetailFoodViewModelActions?
    
    init(detailFoodUseCase: DetailFoodUseCase,
         actions: DetailFoodViewModelActions? = nil) {
        self.detailFoodUseCase = detailFoodUseCase
        self.actions = actions
        
    }
}
