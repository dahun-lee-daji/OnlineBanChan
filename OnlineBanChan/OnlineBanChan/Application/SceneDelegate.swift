//
//  SceneDelegate.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDiContainer = AppDIContainer.init()
    var appFlowCoordinator: AppFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        
        window?.rootViewController = navigationController
        self.appFlowCoordinator = AppFlowCoordinator.init(navigationController: navigationController, appDIContainer: appDiContainer)
        
        self.appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        
    }


}

