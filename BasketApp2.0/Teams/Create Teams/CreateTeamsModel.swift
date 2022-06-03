//
//  CreateTeamsModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import UIKit
import RealmSwift

class CreateTeamsModel
{
    private var realm = try! Realm()
    
    func createTeam(nameOfTeam: String, players stringPlayers: inout [String])
    {
        let team = Team()
        team.accessToName = nameOfTeam
        
        
        while stringPlayers.isEmpty == false
        {
            team.addPlayerToTeam(newPlayer: Player(player: (name: "", number: stringPlayers.removeLast(), dateOfBirth: "", height: "", weight: "")))
        }
        
        
        try! realm.write
        {
            let object = TeamRealm()
            object.accessToTeam = team
            realm.add(object)
        }
    }
    
    func areThisTeamInMemory(name: String) -> Bool
    {
        for item in realm.objects(TeamRealm.self) where item.accessToTeam!.accessToName == name
        {
            return true
        }
        return false
    }
}
