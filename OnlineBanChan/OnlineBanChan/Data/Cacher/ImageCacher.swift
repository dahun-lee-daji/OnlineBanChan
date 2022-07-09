//
//  ImageCacher.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/07/09.
//

import Foundation

class ImageCacher: Cacher {
    
    typealias T = NSData
    
    static var shared = ImageCacher()
    
    private init() {}
    
    let container = NSCache<NSString, T>()
    
}
