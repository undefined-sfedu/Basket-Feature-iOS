//
//  TeamsModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import RealmSwift
class TeamsModel
{
    private var realm = try! Realm()
    
    func getNameOfTeamWithSpecialId(id: Int) -> String
    {
        return realm.objects(TeamRealm.self).reversed()[id].accessToTeam!.accessToName
    }
    
    func getCountOfTeams() -> Int
    {
        return realm.objects(TeamRealm.self).count
    }
    
    func saveTeamForAddingPLayer(id: Int)
    {
        try! realm.write
        {
            let object = TeamForAddingPlayerRealm()
            object.accessToId = id
            realm.objects(TeamForAddingPlayerRealm.self).count == 0 ?(realm.add(object)) : (realm.objects(TeamForAddingPlayerRealm.self).first?.accessToId = id)
            
        }
    }
    
    func deleteTeam(name: String)
    {
        try! realm.write
        {
            for item in realm.objects(TeamRealm.self) where item.accessToTeam!.accessToName == name
            {
                realm.delete(item)
            }
        }
        
    }
}
