//
//  Toaster.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/06/17.
//

import UIKit
import RxSwift

class Toaster {
    
    class ToasterLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setConfigure()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setConfigure()
        }
        
        private func setConfigure() {
            self.numberOfLines = 0
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = .systemGray2
            self.layer.cornerRadius = 10
            self.clipsToBounds = true
            self.font = UIFont.boldSystemFont(ofSize: 20)
            
            let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.removeFromSuperview))
            self.addGestureRecognizer(gesture)
            
            UIView.animate(withDuration: 4.0, delay: 0.1 ,animations: {
                self.alpha = 0
            }, completion: {
                if $0 == true {
                    self.removeFromSuperview()
                }
            })
        }
    }
    
    func showUpWith(text: String, to view: UIView) {
        let label = ToasterLabel.init()
        label.text = text
        
        if view.subviews.contains(where: {
            $0 is ToasterLabel
        }) {
            return
        }
        
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height * 0.7).isActive = true
    }
}
