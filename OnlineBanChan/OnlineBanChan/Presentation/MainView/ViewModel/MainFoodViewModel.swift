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
    let pushFoodDetailView: (String) -> Void
}

protocol MainFoodViewModelInput {
    func didSelect(item: SectionCardItem)
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
            .fetchMainSections()
            .map({
                $0.sorted(by: { lhs, rhs in
                    lhs.categoryId < rhs.categoryId
                })
            })
            .bind(onNext: {self.mainSectionRelay.accept($0)})
            .disposed(by: disposeBag)
    }
    
}

// MARK: - INPUT. View event methods

extension DefaultMainFoodViewModel {
    func didSelect(item: SectionCardItem) {
        actions?.pushFoodDetailView(item.detailHashId)
    }
}

