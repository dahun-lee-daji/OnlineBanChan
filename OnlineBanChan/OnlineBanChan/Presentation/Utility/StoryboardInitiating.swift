//
//  StoryboardInitiating.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import UIKit

protocol StoryboardInitiating: AnyObject {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

extension StoryboardInitiating where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
