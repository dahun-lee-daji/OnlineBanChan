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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        
        window?.rootViewController = navigationController
        self.appFlowCoordinator = AppFlowCoordinator.init(navigationController: navigationController, appDIContainer: appDiContainer)
        
        self.appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        
    }


}

