//
//  DetailFoodViewController.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import UIKit
import RxSwift

class DetailFoodViewController: UIViewController, StoryboardInitiating {
    
    var disposeBag = DisposeBag.init()
    private var viewModel: DetailFoodViewModel!
    
    // - MARK: LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func create(with viewModel: DetailFoodViewModel) -> DetailFoodViewController {
        let view = DetailFoodViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
}
