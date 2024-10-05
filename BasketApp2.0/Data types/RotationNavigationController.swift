//
//  RotationNavigationController.swift
//  BasketApp2.0
//
//  Created by Daniil on 31.01.2022.
//

import UIKit

class RotationNavigationController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
//    override var shouldAutorotate: Bool
//    {
//        return true
//    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
//    {
//        if visibleViewController is GameView || visibleViewController is HistoryView
//        {
//            return .landscape
//        }
//        return .portrait
////        return (visibleViewController is GameView) ? (.landscape) :(.portrait)
//    }
//    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
//    {
//        if visibleViewController is GameView || visibleViewController is HistoryView
//        {
//            return .landscapeRight
//        }
//        return (visibleViewController is GameView) ? (.landscapeRight) :(.portrait)
//    }
}

class RotationTabBarController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool
    {
        
        return true
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return selectedViewController!.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        return selectedViewController!.preferredInterfaceOrientationForPresentation
    }
    
}

class RotationAlertController: UIAlertController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool
    {
        
        return true
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .landscapeRight
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        return .landscapeRight
    }
    
}


