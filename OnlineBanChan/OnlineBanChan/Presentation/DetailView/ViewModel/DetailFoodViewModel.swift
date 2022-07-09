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
    var productName: Observable<String> {get}
    var eventBadge: Observable<[String]> {get}
    var detailDescImage: Observable<Data> {get}
    var thumbnailImage: Observable<Data> {get}
    var itemCountToPurchase: BehaviorSubject<Int> {get}
    var totalPriceToDisplay: BehaviorSubject<String> {get}
    var productDescription: Observable<String> {get}
    var foodPrices: Observable<[String]> {get}
    var deliveryFee: Observable<String> {get}
    var deliveryInfo: Observable<String> {get}
    var pointToEarn: Observable<String> {get}
    
}

protocol DetailFoodViewModel: DetailFoodViewModelInput, DetailFoodViewModelOutput {}

class DefaultDetailFoodViewModel: DetailFoodViewModel {
    
    private let disposeBag = DisposeBag()
    private let detailFoodUseCase: DetailFoodUseCase
    private let actions: DetailFoodViewModelActions?
    private var itemPrice: Int = 0
    private let loadedData: BehaviorSubject<FoodDetail> = .init(value: FoodDetail.init())
    
    // MARK: - OUTPUT
    
    var productName: Observable<String> // initalizer에서 할당
    var eventBadge: Observable<[String]> // initalizer에서 할당
    var detailDescImage: Observable<Data> {
        loadedData.map({
            $0.detailImages
        }).flatMap({
            Observable.from($0)
        }).flatMap({
            self.detailFoodUseCase.fetchFoodImage(imageString: $0)
        })
    }
    
    var thumbnailImage: Observable<Data> {
        loadedData.map({
            $0.thumbnails
        }).flatMap({
            Observable.from($0)
        }).flatMap({
            self.detailFoodUseCase.fetchFoodImage(imageString: $0)
        })
    }
    
    var productDescription: Observable<String> {
        loadedData.map({
            $0.productDescription
        })
    }
    
    var foodPrices: Observable<[String]> {
        loadedData.map({
            $0.prices.sorted(by: >)
        })
    }
    
    var deliveryFee: Observable<String> {
        loadedData.map({
            $0.deliveryFee
        })
    }
    
    var deliveryInfo: Observable<String> {
        loadedData.map({
            $0.deliveryInfo
        })
    }
    
    var pointToEarn: Observable<String> {
        loadedData.map({
            $0.point
        })
    }
    
    var itemCountToPurchase: BehaviorSubject<Int> = .init(value: 0)
    
    var totalPriceToDisplay: BehaviorSubject<String> = .init(value: "")
    
    // MARK: - Init
    
    init(detailFoodUseCase: DetailFoodUseCase,
         actions: DetailFoodViewModelActions? = nil,
         prepare: DetailPreparation) {
        self.detailFoodUseCase = detailFoodUseCase
        self.actions = actions
        self.productName = Observable.just(prepare.productName)
        
        if let badges = prepare.badge {
            self.eventBadge = Observable.just(badges)
        } else {
            self.eventBadge = Observable.empty()
        }
        
        loadData()
        totalPriceBind()
    }
    
    // MARK: - Private ViewModel Funcs
    
    private func loadData() {
        detailFoodUseCase.fetchDetail()
            .bind(to: loadedData)
            .disposed(by: disposeBag)
    }
    
    private func totalPriceBind() {
        
        loadedData.bind(onNext: { [unowned self] in
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
        detailFoodUseCase.mockOrder(orderCount: orderCount)
            .withUnretained(self)
            .bind(onNext: { (owner, orderResult) in
                owner.actions?.presentAlert(orderResult)
            })
            .disposed(by: disposeBag)
    }
    
}
