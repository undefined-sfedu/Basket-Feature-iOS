//
//  WatchOneTeamPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 13.12.2021.
//

import Foundation
import UIKit
class WatchOneTeamPresenter
{
    private var model = WatchOneTeamModel()
    
    func getNumOfPlayers() -> Int
    {
        return model.getNumOfPlayers()
    }
    
    func getNameOfPlayer(id: Int) -> String
    {
        return model.getNameOfPlayer(id: id)
    }
    
    func getNumberOfPlayer(id: Int) -> String
    {
        return model.getNumberOfPlayer(id: id)
    }
    
    func getNameOfTeam() -> String
    {
        return model.getNameOfTeam()
    }
    
    func deleteTeam(id: Int)
    {
        model.deleteTeam(id: id)
    }
    
}
