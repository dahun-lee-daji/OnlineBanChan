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
    var detailFoodRelay: PublishRelay<FoodDetail> {get}
    var productName: BehaviorRelay<String> {get}
    var eventBadge: BehaviorRelay<[String]> {get}
}

protocol DetailFoodViewModel: DetailFoodViewModelInput, DetailFoodViewModelOutput {}

class DefaultDetailFoodViewModel: DetailFoodViewModel {
    
    private let disposeBag = DisposeBag()
    private let detailFoodUseCase: DetailFoodUseCase
    private let actions: DetailFoodViewModelActions?
    
    private var detailImageList: Observable<[String]> {
        detailFoodRelay.map({
            $0.detailImages
        })
    }
    
    private var thumbnailImageList: Observable<[String]> {
        detailFoodRelay.map({
            $0.thumbnails
        })
    }
    
    // MARK: - OUTPUT
    
    let detailFoodRelay: PublishRelay<FoodDetail> = .init()
    let productName: BehaviorRelay<String> = .init(value: "")
    let eventBadge: BehaviorRelay<[String]> = .init(value: [])
    
    // MARK: - Init
    
    init(detailFoodUseCase: DetailFoodUseCase,
         actions: DetailFoodViewModelActions? = nil,
         prepare: DetailPreparation) {
        self.detailFoodUseCase = detailFoodUseCase
        self.actions = actions
        self.productName.accept(prepare.productName)
        
        if let badges = prepare.badge {
            eventBadge.accept(badges)
        }
        
        loadData()
    }
    
    // MARK: - Private ViewModel Funcs
    
    private func loadData() {
        detailFoodUseCase.fetchDetail()
            .bind(to: detailFoodRelay)
            .disposed(by: disposeBag)
    }
}

// MARK: - INPUT. View event methods

extension DefaultDetailFoodViewModel {
    
}
