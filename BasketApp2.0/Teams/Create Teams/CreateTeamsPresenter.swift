//
//  CreateTeamsPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import UIKit
import RealmSwift
class CreateTeamsPresenter
{
    private enum StateOfName
    {
        case okay
        case empty
    }
    private let model = CreateTeamsModel()
    private var view = UIViewController()
    
    func setView(view: CreateTeamsView)
    {
        self.view = view
    }
    
    func addTeam(nameOfTeam: String, players: inout [String])
    {
        
        var wrongPlayer = false
        var changedItem  = ""
        
        for item in players
        {
            if item == "" || item == " "
            {
                wrongPlayer = true
                break
            }
            
        }
        
        if let newView = view as? CreateTeamsView
        {
            if checkNameOfTeam(nameOfTeam: nameOfTeam) == .empty
            {
                newView.alertAboutEmptyNameOfTeam()
            }
            
            else if model.areThisTeamInMemory(name: nameOfTeam)
            {
                newView.alertAboutExistingTeam()
            }
            else if wrongPlayer
            {
                newView.alertAboutWrongPlayer()
            }
            else
            {
                model.createTeam(nameOfTeam: nameOfTeam, players: &players)
                newView.hideView()
            }
        }
        
    }
    
    private func checkNameOfTeam(nameOfTeam: String) -> StateOfName
    {
        var stateOfName: StateOfName
        var changebleNameOfTeam = nameOfTeam
        for item in changebleNameOfTeam
        {
            if item == " "
            {
                changebleNameOfTeam.removeFirst()
            }
        }
        (changebleNameOfTeam.isEmpty ? (stateOfName = .empty) : (stateOfName = .okay))
        
        return stateOfName
    }
}
