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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(with: SectionCardItem, data: Observable<Data>) {

        data.map({
            UIImage.init(data: $0)
        }).bind(to: foodImageView.rx.image)
            .disposed(by: disposeBag)
        
        self.foodTitleLabel.text = with.title
        self.foodDescriptionLabel.text = with.itemDescription
        self.foodPriceLabel.text = with.price
        with.badge?.forEach({
            let badgeLabel = UILabel.init()
            badgeLabel.text = $0
            self.eventBadgeStackView.addArrangedSubview(badgeLabel)
        })
    }
    
}
