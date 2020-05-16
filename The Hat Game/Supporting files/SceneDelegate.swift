//
//  SceneDelegate.swift
//  The Hat Game
//
//  Created by Arthur Duver on 06/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let _ = (scene as? UIWindowScene) else { return }
		
		let skipHelp = UserDefaults.standard.value(forKey: "skipHelp") as? Bool
		
		if skipHelp != true {
			let firstViewController = window?.rootViewController
			window?.rootViewController  = firstViewController?.storyboard?.instantiateViewController(identifier: "informationViewController")
		}
		
		///bouchon pour ResultTable
		if let firstViewController = window?.rootViewController as? ResultViewController {
			let hatGame = HatGame(data: true, result: true)
			firstViewController.hatGame = hatGame
		}
		
		///bouchon pour WhosTurn
		if let firstViewController = window?.rootViewController as? WhosTurnViewController {
			let hatGame = HatGame(data: true, result: false)
			firstViewController.hatGame = hatGame
		}
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
		
		// Save changes in the application's managed object context when the application transitions to the background.
		(UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.saveContext()
	}
	
	
}

