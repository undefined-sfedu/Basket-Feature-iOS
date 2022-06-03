//
//  HistoryPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 14.02.2022.
//

import Foundation
class HistoryPresenter
{
    private var model = HistoryModel()
    
    func getNamesOfTeam() -> [String]
    {
        return model.getNamesOfTeams()
    }
    
    func getCountOfAttacksByTeam(nameOfTeam: String) -> Int
    {
        return model.getCountOfAttacksByTeam(team: nameOfTeam)
    }
    
    // DON'T DELETE info[Attack, Time, Zone, Player, Status]
    func getAttacksByTeam(nameOfTeam: String, id: Int) -> [String]
    {
        let info = model.getAttacksByTeam(team: nameOfTeam, id: id)
        let attack = "\(model.getCountOfAttacksByTeam(team: nameOfTeam) - id)"
        let time =  "\(info.accessToTime)"
        let zone = "\(info.accessToZone)"
        let player = "\(info.accessToPlayer)"
        let result = (info.accessToResult) ? ("Win") : ("Lose")
        return [attack, time, zone, player, result]
    }
    
}
