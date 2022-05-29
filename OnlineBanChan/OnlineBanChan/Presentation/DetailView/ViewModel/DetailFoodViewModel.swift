//
//  DetailFoodViewModel.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import Foundation
import RxSwift
import RxRelay

struct DetailFoodViewModelActions {
    
}

protocol DetailFoodViewModelInput {
}

protocol DetailFoodViewModelOutput {
}

protocol DetailFoodViewModel: DetailFoodViewModelInput, DetailFoodViewModelOutput {}

class DefaultDetailFoodViewModel: DetailFoodViewModel {
    
    private let disposeBag = DisposeBag()
    private let detailFoodUseCase: DetailFoodUseCase
    private let actions: DetailFoodViewModelActions?
    
    // MARK: - OUTPUT
    
    // MARK: - Init
    
    init(detailFoodUseCase: DetailFoodUseCase,
         actions: DetailFoodViewModelActions? = nil) {
        self.detailFoodUseCase = detailFoodUseCase
        self.actions = actions
        loadData()
    }
    
    // MARK: - Private ViewModel Funcs
    
    private func loadData() {
        detailFoodUseCase.fetchDetail()
            
    }
}

// MARK: - INPUT. View event methods

extension DefaultDetailFoodViewModel {
    
}
