//
//  ViewController.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class MainFoodViewController: UIViewController, StoryboardInitiating {

    @IBOutlet weak var mainFoodTableView: UITableView!
    
    var disposeBag = DisposeBag.init()
    
    private var viewModel: MainFoodViewModel!
    
    // - MARK: LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTableViewCell()
        bind()
    }
    
    static func create(with viewModel: MainFoodViewModel) -> MainFoodViewController {
        let view = MainFoodViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    // - MARK: View Settings
    
    private func setupView() {
        self.title = viewModel.sceneTitle
    }
    
    private func bind() {
        viewModel.mainSectionRelay
            .scan(into: [], accumulator: {(old, new) in
                old.append(contentsOf: new)
            })
            .bind(to: mainFoodTableView.rx
                .items(dataSource: viewModel.dataSource)
            )
            .disposed(by: disposeBag)
        
        mainFoodTableView.rx.modelSelected(SectionCardItem.self)
            .asObservable()
            .bind(onNext: { selectedItem in
                self.viewModel.didSelect(item: selectedItem)
            })
            .disposed(by: disposeBag)
    }
    
    private func setTableViewCell() {
        let tableViewCellNib = UINib(nibName: FoodListItemCell.className, bundle: nil)
        mainFoodTableView.register(tableViewCellNib, forCellReuseIdentifier: FoodListItemCell.className)
        
        let tableViewHeaderNib = UINib(nibName: FoodListHeader.className, bundle: nil)
        mainFoodTableView.register(tableViewHeaderNib, forHeaderFooterViewReuseIdentifier: FoodListHeader.className)
        
        mainFoodTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}

extension MainFoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FoodListHeader.className) as? FoodListHeader else {return UIView() }
        
        let currentSection = viewModel.sectionData[section]
        
        view.setTitle(text: currentSection.name)
        
        view.sectionTitleButton.rx.tap
            .bind(onNext: { [unowned self] in
                viewModel.sectionTouched(sectionName: currentSection.name, sectionItemCount: currentSection.items.count)
            })
            .disposed(by: disposeBag)
        
        return view
    }
}
