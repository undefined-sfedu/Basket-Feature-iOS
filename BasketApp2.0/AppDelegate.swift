//
//  AppDelegate.swift
//  BasketApp2.0
//
//  Created by Daniil on 01.12.2021.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
private var realm = try! Realm()

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
//        try! realm.write
//        {
//        realm.delete(realm.objects(DoneGameRealm.self))
//            realm.deleteAll()
//        }
        
        
        
        let view = SignView()
        let root = RotationNavigationController(rootViewController: view)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }

    

}


