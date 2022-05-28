//
//  FoodListHeader.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/28.
//

import UIKit

class FoodListHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionTitle: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        designateSubView()
        self.contentView.addSubview(sectionTitle)
    }
    
    func setTitle(text: String) {
        self.sectionTitle.text = text
    }
    
    private func designateSubView() {
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: self.topAnchor),
            sectionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
