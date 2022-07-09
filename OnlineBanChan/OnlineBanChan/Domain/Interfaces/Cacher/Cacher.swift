//
//  Cacher.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/07/09.
//

import Foundation


protocol Cacher {
    associatedtype T: AnyObject
    
    var container: NSCache<NSString, T> {get}
    
    func setCache(with data: T, id: String)
    func getCache(id: String) -> T?
}

extension Cacher {
    
    func setCache(with data: T, id: String) {
        container.setObject(data, forKey: id as NSString)
    }
    
    func getCache(id: String) -> T? {
        container.object(forKey: id as NSString)
    }
}
