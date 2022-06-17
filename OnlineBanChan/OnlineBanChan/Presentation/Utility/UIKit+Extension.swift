//
//  UIKit+Extension.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/06/17.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF)/255.0,
            green: CGFloat((rgb >> 8) & 0xFF)/255.0,
            blue: CGFloat(rgb & 0xFF)/255.0,
            alpha: 1
        )
    }
}

extension UILabel {
    
    convenience init(text: String) {
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
    
    func setPriceLabelWith(array: [String?]) {
        
        let array = array.compactMap({$0})
        
        var clippedArray = array.count >= 3 ? array.prefix(through: 2).map({$0}) : array
        clippedArray.sort(by: <)
        
        guard let first = clippedArray.first ,
              let last = clippedArray.last else {
            return
        }
        
        if first != last {
            setPriceLabelWith(default: last, discount: first)
        } else {
            setPriceLabelWith(default: first, discount: nil)
        }
    }
    
    func setPriceLabelWith(default price: String, discount: String?) {
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
