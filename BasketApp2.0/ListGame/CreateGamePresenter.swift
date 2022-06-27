//
//  CreateGamePresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.12.2021.
//

import UIKit
class CreateGamePresenter
{
    private let model = CreateGameModel()
    private var view = UIViewController()
    
    
    
    func setView(view: CreateGameView)
    {
        self.view = view
    }
    
    func markTeam(teamA: Bool) -> ShowTeamView
    {
        model.markTeam(teamA: teamA)
        let view = ShowTeamView()
        view.setTeams(teams: model.getListOfTeams())
        return view
    }
    
    func setTeam(nameOfTeam: String)
    {
        model.setTeams(nameOfTeam: nameOfTeam)
        if let newView = view as? CreateGameView
        {
            let nameOfTeamA = model.getNameOfTeam(teamA: true)
            let nameOfTeamB = model.getNameOfTeam(teamA: false)
            
            if nameOfTeamA != ""
            {
                newView.updateLabelsOfTeams(nameOfTeam: nameOfTeamA, teamA: true)
            }
            if nameOfTeamB != ""
            {
                newView.updateLabelsOfTeams(nameOfTeam: nameOfTeamB, teamA: false)
            }
        }
    }
    
    func createGame(name: String)
    {
        let nameOfTeamA = model.getNameOfTeam(teamA: true)
        let nameOfTeamB = model.getNameOfTeam(teamA: false)
        
        if let newView = view as? CreateGameView
        {
            if nameOfTeamA == nameOfTeamB
            {
                newView.alertAboutWrongInfo(typeOfMistake: .identicalTeams)
            }
            else if nameOfTeamA.isEmpty || nameOfTeamB.isEmpty
            {
                newView.alertAboutWrongInfo(typeOfMistake: .emptyNameOfTeam)
            }
            else if model.areThisGameInMemory(name: name)
            {
                newView.alertAboutWrongInfo(typeOfMistake: .identicalGames)
            }
            else
            {
                model.createGame(name: name)
                newView.letsBeginGame()
            }
            
        }
    }
    
}
