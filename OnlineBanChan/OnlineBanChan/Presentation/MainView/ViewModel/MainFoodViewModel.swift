//
//  MainFoodViewModel.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

struct MainFoodViewModelActions {
    let pushFoodDetailView: (DetailPreparation) -> Void
    let showToast: (String) -> Void
}

protocol MainFoodViewModelInput {
    func didSelect(item: SectionCardItem)
    func sectionTouched(sectionName: String, sectionItemCount: Int)
}

protocol MainFoodViewModelOutput {
    var sceneTitle: String {get}
    var mainSectionRelay: BehaviorRelay<[MainSection]> {get}
    var dataSource: RxTableViewSectionedAnimatedDataSource<MainSection> {get}
}

protocol MainFoodViewModel: MainFoodViewModelInput, MainFoodViewModelOutput {}

class DefaultMainFoodViewModel: MainFoodViewModel {
    
    private let disposeBag = DisposeBag()
    private let mainFoodUseCase: MainFoodUseCase
    private let actions: MainFoodViewModelActions?
    
    // MARK: - OUTPUT
    
    let mainSectionRelay: BehaviorRelay<[MainSection]> = .init(value: [])
    let sceneTitle: String = "OnlineBanchan"
    var dataSource
    : RxTableViewSectionedAnimatedDataSource<MainSection> {
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<MainSection> {
            (dataSource, tableView, indexPath, sectionCardItem) -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodListItemCell.className) as? FoodListItemCell else {
                return UITableViewCell()
            }
            
            let imageData = self.mainFoodUseCase
                .fetchFoodImage(imageString: sectionCardItem.imageString)
            
            cell.bind(with: sectionCardItem,
                      data: imageData)
            
            return cell
        }
        
        return dataSource
        
    }
    
    
    // MARK: - Init

    init(mainFoodUseCase: MainFoodUseCase,
         actions: MainFoodViewModelActions? = nil) {
        self.mainFoodUseCase = mainFoodUseCase
        self.actions = actions
        loadData()
    }
    
    // MARK: - Private ViewModel Funcs
    
    private func loadData() {
        mainFoodUseCase
            .fetchBestSections()
            .map({
                $0.sorted(by: { lhs, rhs in
                    lhs.categoryId < rhs.categoryId
                })
            })
            .bind(onNext: {self.mainSectionRelay.accept($0)})
            .disposed(by: disposeBag)
        
        let main = mainFoodUseCase.fetchIndividualSection(api: .main)
        let soup = mainFoodUseCase.fetchIndividualSection(api: .soup)
        let side = mainFoodUseCase.fetchIndividualSection(api: .side)
        
        let merged = Observable.concat([main, soup, side])
        
        merged.bind(onNext: { sectionToAdd in
            self.mainSectionRelay.accept(sectionToAdd)
        })
        .disposed(by: disposeBag)
    }
    
}

// MARK: - INPUT. View event methods

extension DefaultMainFoodViewModel {
    func didSelect(item: SectionCardItem) {
        let prepare = DetailPreparation
            .init(productName: item.title,
                  hashId: item.detailHashId,
                  badge: item.badge)
        actions?.pushFoodDetailView(prepare)
    }
    
    func sectionTouched(sectionName: String, sectionItemCount: Int) {
        actions?.showToast(" \(sectionName)은 \(sectionItemCount.description)개 있어요! ")
    }
}

