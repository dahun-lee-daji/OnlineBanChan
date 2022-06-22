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
        let range = (text as NSString).range(of: text)
        let attributed = NSMutableAttributedString.init(string: text)
        
        attributed.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 30), range: range)
        
        self.sectionTitleButton.setAttributedTitle(attributed, for: .normal)
        
    }
    
}
