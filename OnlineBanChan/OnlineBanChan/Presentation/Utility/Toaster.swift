//
//  Toaster.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/06/17.
//

import UIKit
import RxSwift

class Toaster {
    
    func showUpWith(text: String, to view: UIView) {
        let label = makeToasterLabel(text: text)
        
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height * 0.7).isActive = true
    }
    
    private func makeToasterLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray2
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.text = text
        
        UIView.animate(withDuration: 4.0, delay: 0.1 ,animations: {
            label.alpha = 0
        }, completion: {
            if $0 == true {
                label.removeFromSuperview()
            }
        })
        
        return label
    }
}
