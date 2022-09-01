//
//  SceneDelegate.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 27.08.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let viewActive = UserDefaults.standard.integer(forKey: "viewActive")
        let mainVC = ViewController()
        let navVC = NavigationController()
        print(viewActive)
        if viewActive == 1 {
            let gameVC = GameViewController()
            navVC.viewControllers = [gameVC]
            
        } else {
            UserDefaults.standard.removeObject(forKey: "gamersArraySaved")
            UserDefaults.standard.removeObject(forKey: "redoArraySaved")
            navVC.viewControllers = [mainVC]
        }
        
        UINavigationBar.appearance().tintColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        
        UINavigationBar.appearance().isTranslucent = false
        navVC.navigationBar.barTintColor = UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1)
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    @available(iOS 13, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    @available(iOS 13, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    @available(iOS 13, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    @available(iOS 13, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    @available(iOS 13, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

