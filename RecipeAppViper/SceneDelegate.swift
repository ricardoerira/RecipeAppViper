//
//  SceneDelegate.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 04/07/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
   //     let navController = UINavigationController(rootViewController: RecipeSearchRouter.createModule()) // Creating a navigation controller with VC1 at the root of the navigation stack.
        
        let rootViewController = RecipeSearchRouter.createModule() // Assuming you have a function to create the root view controller in the RecipesRouter
             let navigationController = UINavigationController(rootViewController: rootViewController)
         //    window.rootViewController = navigationController

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}

