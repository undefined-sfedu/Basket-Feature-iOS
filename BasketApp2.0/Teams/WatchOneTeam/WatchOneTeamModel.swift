//
//  WatchOneTeamModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 13.12.2021.
//

import UIKit
import RealmSwift
class WatchOneTeamModel
{
    private var realm: Realm
    private var idOfTeam: Int
    private var team: TeamRealm
    
    init()
    {
        realm = try! Realm()
        idOfTeam = realm.objects(TeamForAddingPlayerRealm.self).first!.accessToId
        team = realm.objects(TeamRealm.self).reversed()[idOfTeam]
    }
    
    
    
    func getNumOfPlayers() -> Int
    {
//        team = realm.objects(TeamRealm.self).reversed()[idOfTeam]
        return team.accessToTeam!.getNumOfPlayers
    }
    
    func getNameOfPlayer(id: Int) -> String
    {
        return team.accessToTeam!.getInfoAboutPlayers(id: id, typeOfInfo: .name)
    }
    
    func getNumberOfPlayer(id: Int) -> String
    {
        return team.accessToTeam!.getInfoAboutPlayers(id: id, typeOfInfo: .number)
    }
    
    func getNameOfTeam() -> String
    {
        return team.accessToTeam!.accessToName
    }
    
    func deleteTeam(id: Int)
    {
        print(team.accessToTeam?.getNumOfPlayers)
        try! realm.write
        {
            let newTeam = team.accessToTeam
            newTeam?.removePlayer(id: id)
            team.accessToTeam = newTeam
        }
//        team.accessToTeam!.removePlayer(id: id)
        print(team.accessToTeam?.getNumOfPlayers)
    }
}
