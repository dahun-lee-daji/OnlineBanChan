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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
            .bind(to: mainFoodTableView.rx
                .items(dataSource: viewModel.dataSource())
            )
            .disposed(by: disposeBag)
    }
    
    private func setTableViewCell() {
        let myTableViewCellNib = UINib(nibName: FoodListItemCell.className, bundle: nil)
        mainFoodTableView.register(myTableViewCellNib, forCellReuseIdentifier: FoodListItemCell.className)
        mainFoodTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}

extension MainFoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
