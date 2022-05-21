//
//  ViewController.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    var disposeBag = DisposeBag.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let test = NetworkService.init()
        let result = test.getSections()
            .asObservable()
            .debug()
            .subscribe(onNext: { _ in },
                       onError: { _ in},
                       onCompleted: { },
                       onDisposed: {  })
            .disposed(by: disposeBag)
            
        
    }

}

