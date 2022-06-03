//
//  TeamsPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
class TeamsPresenter
{
    private let model = TeamsModel()
    
    
    func getNameOfTeamWithSpecialId(id: Int) -> String
    {
        return model.getNameOfTeamWithSpecialId(id: id)
    }
    
    func getCountOfTeams() -> Int
    {
        return model.getCountOfTeams()
    }
    
    func saveTeamForAddingPLayer(id: Int)
    {
        model.saveTeamForAddingPLayer(id: id)
    }
    func deleteTeam(name: String)
    {
        model.deleteTeam(name: name)
    }
}
