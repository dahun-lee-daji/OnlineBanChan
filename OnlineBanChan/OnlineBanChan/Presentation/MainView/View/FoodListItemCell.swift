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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(with item: SectionCardItem, data: Observable<Data>) {

        data.map({
            UIImage.init(data: $0)
        }).bind(to: foodImageView.rx.image)
            .disposed(by: disposeBag)
        
        self.foodTitleLabel.text = item.title
        self.foodDescriptionLabel.text = item.itemDescription
        self.foodPriceLabel.setPriceLabelWith(default: item.price, discount: item.discountPrice)
        item.badge?.forEach({
            let badgeLabel = UILabel.init(text: $0)
            self.eventBadgeStackView.addArrangedSubview(badgeLabel)
        })
    }
    
}

extension UIColor {
    fileprivate convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF)/255.0,
            green: CGFloat((rgb >> 8) & 0xFF)/255.0,
            blue: CGFloat(rgb & 0xFF)/255.0,
            alpha: 1
        )
    }
}

extension UILabel {
    
    fileprivate convenience init(text: String) {
        self.init(frame: CGRect.init(x: 0, y: 0, width: 90, height: 30))
        let colorDictionary: [String: UIColor] = ["이벤트특가": .init(rgb: 0x80BCFF),
                                                  "런칭특가":.init(rgb: 0x0066D6)]
        self.text = "  \(text)  "
        self.font = UIFont.boldSystemFont(ofSize: 12)
        self.textColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.backgroundColor = colorDictionary[text] ?? UIColor.black
    }
    
    fileprivate func setPriceLabelWith(default price: String, discount: String?) {
        var wholeString = String()
        
        if let unwraped = discount {
            wholeString = unwraped + " " + price
        } else {
            wholeString = price
        }
        
        let attributedString = NSMutableAttributedString.init(string: wholeString)
        
        let toBold = discount ?? price
        let boldRange = (wholeString as NSString).range(of: toBold)
        
        if toBold == discount {
            let lineThroughRange = (wholeString as NSString).range(of: price)
            attributedString
                .addAttributes([.foregroundColor: UIColor.systemGray2,
                                .strikethroughStyle: 2],
                               range: lineThroughRange)
            
        }
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: boldRange)
        self.attributedText = attributedString
        
    }
}
