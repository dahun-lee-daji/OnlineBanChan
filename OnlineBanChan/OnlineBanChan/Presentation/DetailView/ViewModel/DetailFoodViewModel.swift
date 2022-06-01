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
    var detailDescImage: Observable<Data> {get}
    var thumbnailImage: Observable<Data> {get}
}

protocol DetailFoodViewModel: DetailFoodViewModelInput, DetailFoodViewModelOutput {}

class DefaultDetailFoodViewModel: DetailFoodViewModel {
    
    private let disposeBag = DisposeBag()
    private let detailFoodUseCase: DetailFoodUseCase
    private let actions: DetailFoodViewModelActions?
    
    // MARK: - OUTPUT
    
    let detailFoodRelay: PublishRelay<FoodDetail> = .init()
    let productName: BehaviorRelay<String> = .init(value: "")
    let eventBadge: BehaviorRelay<[String]> = .init(value: [])
    var detailDescImage: Observable<Data> {
        detailFoodRelay.map({
            $0.detailImages
        }).flatMap({
            Observable.from($0)
        }).flatMap({
            self.detailFoodUseCase.fetchFoodImage(imageString: $0)
        })
    }
    
    var thumbnailImage: Observable<Data> {
        detailFoodRelay.map({
            $0.thumbnails
        }).flatMap({
            Observable.from($0)
        }).flatMap({
            self.detailFoodUseCase.fetchFoodImage(imageString: $0)
        })
    }
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
