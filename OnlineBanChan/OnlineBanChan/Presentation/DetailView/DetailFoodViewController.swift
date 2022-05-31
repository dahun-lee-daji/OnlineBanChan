//
//  DetailFoodViewController.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import UIKit
import RxSwift

class DetailFoodViewController: UIViewController, StoryboardInitiating {
    
    @IBOutlet weak var thumbnatilContentView: UIView!
    @IBOutlet weak var foodDescImageStackView: UIStackView!
    
    @IBOutlet weak var imagePagingScrollView: UIScrollView!
    @IBOutlet weak var imagePageController: UIPageControl!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var eventBadgeStackView: UIStackView!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var delyveryInfoLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    private let disposeBag = DisposeBag.init()
    private var viewModel: DetailFoodViewModel!
    
    // - MARK: LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    static func create(with viewModel: DetailFoodViewModel) -> DetailFoodViewController {
        let view = DetailFoodViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    // - MARK: View Settings
    
    func bind() {
        
        viewModel.productName
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.productName
            .asDriver()
            .drive(productNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.detailFoodRelay
            .map({
                $0.productDescription
            })
            .bind(to: productDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
            
        
        viewModel.detailFoodRelay
            .map({
                $0.prices
            })
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { (owner, prices) in
                owner.productPrice.setPriceLabelWith(default: prices[0], discount: prices.last)
            })
            .disposed(by: disposeBag)
            
        
        viewModel.detailFoodRelay
            .map({
                $0.deliveryFee
            })
            .bind(to: deliveryFeeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.detailFoodRelay
            .map({
                $0.deliveryInfo
            })
            .bind(to: delyveryInfoLabel.rx.text)
            .disposed(by: disposeBag)
            
        viewModel.detailFoodRelay
            .map({
                $0.point
            })
            .bind(to: pointLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.eventBadge
            .map({
                $0.map({
                    UILabel.init(text: $0)
                })
            })
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (owner, labels) in
                labels.forEach({
                    owner.eventBadgeStackView.addArrangedSubview($0)
                })
            })
            .disposed(by: disposeBag)
        
        viewModel.detailDescImage
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (owner, data) in
                let image = UIImageView.init(image: UIImage.init(data: data))
                image.contentMode = .scaleAspectFit
                owner.foodDescImageStackView.addArrangedSubview(image)
            })
            .disposed(by: disposeBag)
        
//        viewModel.thumbnailImage
//            .subscribe(onNext: {
//                self.thumbnatilContentView.addSubview(
//                    UIImageView.init(image: UIImage.init(data: $0))
//                )
//            })
//            .disposed(by: disposeBag)
        
    }
}
