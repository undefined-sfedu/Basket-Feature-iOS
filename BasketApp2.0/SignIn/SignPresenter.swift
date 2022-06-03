//
//  SignPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 01.12.2021.
//
import UIKit
import SnapKit
class SignPresenter
{
    private var model = SignModel()

    func forgetPassword()
    {
        
    }
   
    func getRegisterView() -> UIViewController
    {
        let view = RegisterView()
        return view
    }
    
    func getTabBarController() -> UITabBarController
    {
        let tabBar = RotationTabBarController()
        let controllers = [RotationNavigationController(rootViewController: ProfileView()), RotationNavigationController(rootViewController: TeamsView()), RotationNavigationController(rootViewController: ListGameView())]
        let namesOfControllers = ["Profile", "Teams", "Games"]
       
        tabBar.setViewControllers(controllers, animated: true)
        for i in 0..<tabBar.tabBar.items!.count
        {
            tabBar.tabBar.items![i].title = namesOfControllers[i]
        }
        
        tabBar.tabBar.backgroundColor = .white
        
        return tabBar
    }
   
}
