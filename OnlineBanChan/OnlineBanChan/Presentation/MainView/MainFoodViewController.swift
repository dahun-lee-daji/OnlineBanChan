//
//  ViewController.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa

class MainFoodViewController: UIViewController, StoryboardInitiating {

    var disposeBag = DisposeBag.init()
    
    private var viewModel: MainFoodViewModel!
    private var banchanRepository: BanChanRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func create(with viewModel: MainFoodViewModel,
                       banchanRepository: BanChanRepository?) -> MainFoodViewController {
        let view = MainFoodViewController.instantiateViewController()
        view.viewModel = viewModel
        view.banchanRepository = banchanRepository
        return view
    }

}

