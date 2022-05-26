//
//  FoodListItemCell.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit

class FoodListItemCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var eventBadgeStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(with: SectionCardItem) {
        self.foodImageView = .init(image: UIImage.init())
        self.foodTitleLabel.text = with.title
        self.foodDescriptionLabel.text = with.itemDescription
        self.foodPriceLabel.text = with.price
    }
    
}
