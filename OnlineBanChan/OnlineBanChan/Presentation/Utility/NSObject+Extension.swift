//
//  NSObject+Extension.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
