//
//  FoodListHeader.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import UIKit

class FoodListHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionTitleButton: UIButton!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitle(text: String) {
        self.sectionTitleButton.setTitle(text, for: .normal)
    }
    
}
