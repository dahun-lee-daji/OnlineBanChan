//
//  DetailFoodViewController.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import UIKit
import RxSwift
import RxCocoa

class DetailFoodViewController: UIViewController, StoryboardInitiating {
    
    @IBOutlet weak var imagePagingScrollView: UIScrollView!
    @IBOutlet weak var imagePageController: UIPageControl!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var eventBadgeStackView: UIStackView!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var foodDescImageStackView: UIStackView!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityCountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
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
            .asDriver(onErrorJustReturn: "error")
            .drive(self.rx.title, productNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.productDescription
            .asDriver(onErrorJustReturn: "error")
            .drive(productDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.foodPrices
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { (owner, prices) in
                owner.productPrice.setPriceLabelWith(default: prices.first ?? "0", discount: prices.last)
            })
            .disposed(by: disposeBag)
        
        viewModel.deliveryFee
            .bind(to: deliveryFeeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.deliveryInfo
            .bind(to: deliveryInfoLabel.rx.text)
            .disposed(by: disposeBag)
            
        viewModel.pointToEarn
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
        
        viewModel.thumbnailImage
            .withUnretained(self)
            .subscribe(onNext: { (owner, data) in
                owner.addContentScrollView(image: UIImage.init(data: data))
            })
            .disposed(by: disposeBag)
        
        imagePagingScrollView.rx.contentOffset
            .asObservable()
            .withUnretained(self.imagePagingScrollView)
            .map({ (scrollView, offset) in
                return Int((offset.x / scrollView.frame.size.width).rounded())
            })
            .bind(to: imagePageController.rx.currentPage)
            .disposed(by: disposeBag)
        
        viewModel.thumbnailImage
            .scan(imagePageController.numberOfPages, accumulator: { numberOfPages ,_ in
                numberOfPages + 1
            })
            .bind(to: imagePageController.rx.numberOfPages)
            .disposed(by: disposeBag)
        
        quantityStepper.rx.value
            .map({
                Int($0.rounded())
            })
            .bind(to: viewModel.itemCountToPurchase)
            .disposed(by: disposeBag)
        
        viewModel.itemCountToPurchase
            .map({String($0)})
            .asDriver(onErrorDriveWith: .just("Error"))
            .drive(quantityCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPriceToDisplay
            .asDriver(onErrorDriveWith: .just("Error"))
            .drive(totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        orderButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { (owner, _) in
                owner.viewModel.touchOrderButton()
            })
            .disposed(by: disposeBag)
        
    }
    
    private func addContentScrollView(image : UIImage?) {
        
        DispatchQueue.main.async { [unowned self] in
            
            let imageViewCountInScrollView = imagePagingScrollView.subviews.filter({
                $0 is UIImageView
            }).count
            
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(imageViewCountInScrollView)
            imageView
                .frame = CGRect(x: xPos,
                                y: 0,
                                width: imagePagingScrollView.bounds.width,
                                height: imagePagingScrollView.bounds.height)
            imageView.image = image
            imagePagingScrollView.addSubview(imageView)
            imagePagingScrollView.contentSize.width = imageView.frame.width * CGFloat(imageViewCountInScrollView + 1)
        }
        
    }
}
