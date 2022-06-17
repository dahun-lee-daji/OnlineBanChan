//
//  FoodListItemCell.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit
import RxCocoa
import RxSwift

class FoodListItemCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var eventBadgeStackView: UIStackView!
    
    let disposeBag = DisposeBag()
    var detailHashId = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.foodImageView.clipsToBounds = true
        self.foodImageView.layer.cornerRadius = 18
    }
    
    override func prepareForReuse() {
        self.foodImageView.image = nil
        self.foodTitleLabel.text = ""
        self.foodDescriptionLabel.text = ""
        self.foodPriceLabel.text = ""
        self.eventBadgeStackView.subviews.forEach({
            $0.removeFromSuperview()
        })
    }
    
    func bind(with item: SectionCardItem, data: Observable<Data>) {

        data.map({
            UIImage.init(data: $0)
        }).bind(to: foodImageView.rx.image)
            .disposed(by: disposeBag)
        
        self.foodTitleLabel.text = item.title
        self.foodDescriptionLabel.text = item.itemDescription
        self.foodPriceLabel.setPriceLabelWith(array: [item.priceToSale, item.priceOfNormal])
        item.badge?.forEach({
            let badgeLabel = UILabel.init(text: $0)
            self.eventBadgeStackView.addArrangedSubview(badgeLabel)
        })
        self.detailHashId = item.detailHashId
    }
    
}
