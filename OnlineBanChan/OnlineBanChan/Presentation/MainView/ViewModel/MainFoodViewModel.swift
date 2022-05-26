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
    
}

protocol MainFoodViewModelInput {
}

protocol MainFoodViewModelOutput {
    var sceneTitle: String {get}
    var dataSource: RxTableViewSectionedAnimatedDataSource<MainSection> {get}
    var mainSectionSubject: PublishSubject<[MainSection]> {get}
}

protocol MainFoodViewModel: MainFoodViewModelInput, MainFoodViewModelOutput {}

class DefaultMainFoodViewModel: MainFoodViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let mainFoodUseCase: MainFoodUseCase
    private let actions: MainFoodViewModelActions?
    let mainSectionSubject: PublishSubject<[MainSection]> = .init()
    
    // MARK: - OUTPUT

    var sceneTitle: String = "OnlineBanchan"
    let dataSource: RxTableViewSectionedAnimatedDataSource<MainSection> = {
            let dataSource = RxTableViewSectionedAnimatedDataSource<MainSection> { (dataSource, tableView, indexPath, sectionCardItem) -> UITableViewCell in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodListItemCell.className) as? FoodListItemCell else {
                    return UITableViewCell()
                }
                
                cell.bind(with: sectionCardItem)
                return cell
            }
        
        dataSource.titleForHeaderInSection = { (dataSource, index) in
            
            return dataSource.sectionModels[index].name
        }
            
            return dataSource
        }()
    
    // MARK: - Init

    init(mainFoodUseCase: MainFoodUseCase,
         actions: MainFoodViewModelActions? = nil) {
        self.mainFoodUseCase = mainFoodUseCase
        self.actions = actions
        loadData()
    }
    
    // MARK: - Private ViewModel Funcs
    
    func loadData() {
        mainFoodUseCase.fetchMainSections()
            .map({
                $0.sorted(by: { lhs, rhs in
                    lhs.categoryId < rhs.categoryId
                })
            })
            .subscribe({ observer in
                switch observer {
                case.next(let mainSections):
                    self.mainSectionSubject.onNext(mainSections)
                case.error(let error):
                    fatalError("\(Self.self) \(error)")
                case .completed:
                    break
                }
            })
            .disposed(by: disposeBag)
            
    }
}

// MARK: - INPUT. View event methods

extension DefaultMainFoodViewModel {
    
}
