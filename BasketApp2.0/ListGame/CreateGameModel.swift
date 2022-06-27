//
//  CreateGameModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.12.2021.
//

import UIKit
import RealmSwift
class CreateGameModel
{
    private var realm: Realm
    private var teams: [TeamRealm]
    private var teamA = Team()
    private var teamB = Team()
    private var needSetTeamA = false
    
    init()
    {
        self.realm = try! Realm()
        self.teams = realm.objects(TeamRealm.self).reversed()
    }
    
//    func setPresenter(presenter: CreateGamePresenter)
//    {
//        self.presenter = presenter
//    }
    
    func getListOfTeams() -> [String]
    {
        var nameOfTeams = [String]()
        for item in teams
        {
            nameOfTeams.append(item.accessToTeam!.accessToName)
        }
        return nameOfTeams
    }
    
    func markTeam(teamA: Bool)
    {
        needSetTeamA = (teamA ? (true) : (false))
    }
    
    func setTeams(nameOfTeam: String)
    {
        for item in teams
        {
            if item.accessToTeam!.accessToName == nameOfTeam
            {
                needSetTeamA ? (self.teamA = item.accessToTeam!) : (self.teamB = item.accessToTeam!)
                break
            }
        }
    }
    
    func getNameOfTeam(teamA: Bool) -> String
    {
        return teamA ? (self.teamA.accessToName) : (self.teamB.accessToName)
    }
    
    func createGame(name: String)
    {
        let game = CurrentGame(teamA: teamA, teamB: teamB, name: name)
        try! realm.write
        {
            let object = CurrentGameRealm()
            object.accessToGame = game
            realm.objects(CurrentGameRealm.self).count == 1 ? (realm.objects(CurrentGameRealm.self).first!.accessToGame = object.accessToGame) : (realm.add(object))
        }
    }
    
    func areThisGameInMemory(name: String) -> Bool
    {
        for item in realm.objects(DoneGameRealm.self) where item.accessToGame!.accessToName == name
        {
            return true
        }
        return false
    }
}
