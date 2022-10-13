//
//  SceneDelegate.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 08.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootNavigationController = UINavigationController()
        let container = ProjectFactory()
        let coordinator = container.makeInitialCoordinator()
                
        coordinator.start(with: rootNavigationController)
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

