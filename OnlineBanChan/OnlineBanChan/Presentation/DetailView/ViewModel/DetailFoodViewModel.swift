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
    let presentAlert: (Bool) -> Void
}

protocol DetailFoodViewModelInput {
    func touchOrderButton() -> Void
}

protocol DetailFoodViewModelOutput {
    var detailFoodRelay: PublishRelay<FoodDetail> {get}
    var productName: BehaviorRelay<String> {get}
    var eventBadge: BehaviorRelay<[String]> {get}
    var detailDescImage: Observable<Data> {get}
    var thumbnailImage: Observable<Data> {get}
    var itemCountToPurchase: BehaviorSubject<Int> {get}
    var totalPriceToDisplay: BehaviorRelay<String> {get}
}

protocol DetailFoodViewModel: DetailFoodViewModelInput, DetailFoodViewModelOutput {}

class DefaultDetailFoodViewModel: DetailFoodViewModel {
    
    private let disposeBag = DisposeBag()
    private let detailFoodUseCase: DetailFoodUseCase
    private let actions: DetailFoodViewModelActions?
    private var itemPrice: Int = 0
    
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
    
    var itemCountToPurchase: BehaviorSubject<Int> = .init(value: 0)
    
    var totalPriceToDisplay: BehaviorRelay<String> = .init(value: "")
    
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
        distribute()
    }
    
    // MARK: - Private ViewModel Funcs
    
    private func loadData() {
        detailFoodUseCase.fetchDetail()
            .bind(to: detailFoodRelay)
            .disposed(by: disposeBag)
    }
    
    private func distribute() {
        
        detailFoodRelay.bind(onNext: { [unowned self] in
            let prices = $0.prices
                .map({
                    $0.filter({
                        $0.isNumber
                    })
                })
            if let minValue = prices.min(),
               let intMinValue = Int(minValue) {
                itemPrice = intMinValue
            }
        })
        .disposed(by: disposeBag)
        
        itemCountToPurchase
            .map({ [unowned self] in
                String($0 * itemPrice) + " 원"
            })
            .bind(to: totalPriceToDisplay)
            .disposed(by: disposeBag)
    }
}

// MARK: - INPUT. View event methods

extension DefaultDetailFoodViewModel {
    func touchOrderButton() -> Void {
        let orderCount = try! itemCountToPurchase.value()
        detailFoodUseCase.mockOrderFunc(orderCount: orderCount)
            .withUnretained(self)
            .bind(onNext: { (owner, orderResult) in
                owner.actions?.presentAlert(orderResult)
            })
            .disposed(by: disposeBag)
    }
    
}
