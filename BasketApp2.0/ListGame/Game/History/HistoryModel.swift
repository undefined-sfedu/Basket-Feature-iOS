//
//  HistoryModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 14.02.2022.
//

import Foundation
import RealmSwift
class HistoryModel
{
    let realm = try! Realm()
    var currentGames: CurrentGame
    
    init()
    {
        currentGames = realm.objects(CurrentGameRealm.self).first!.accessToGame!
    }
    
    func getNamesOfTeams() -> [String] // [teamA, teamB]
    {
        return [currentGames.accessToTeamA.accessToName, currentGames.accessToTeamB.accessToName]
    }
    
    func getAttacksByTeam(team: String, id: Int) -> Attack
    {
        var attacks = [Attack]()
        let itIsTeamA = (team == currentGames.accessToTeamA.accessToName)
        for item in self.currentGames.accessToAttacks where item.accessToTeamA == itIsTeamA
        {
            attacks.append(item)
        }
        return attacks[id]
    }
    
    func getCountOfAttacksByTeam(team: String) -> Int
    {
        var count = 0
        let itIsTeamA = (team == currentGames.accessToTeamA.accessToName)
        for item in currentGames.accessToAttacks where item.accessToTeamA == itIsTeamA
        {
            count += 1
        }
        
        return count
        
    }
}
