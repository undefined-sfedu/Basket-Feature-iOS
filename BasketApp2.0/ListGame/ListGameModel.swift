//
//  GamesModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import RealmSwift
class ListGameModel
{
    private var realm: Realm
    private var games: [DoneGameRealm]
    init()
    {
        self.realm = try! Realm()
        self.games = realm.objects(DoneGameRealm.self).reversed()
    }
    func getCountOfGames() -> Int
    {
        //        return games.count
        return realm.objects(DoneGameRealm.self).reversed().count
    }
    
    func getNameAndDateOfGameById(id: Int) -> (String, String) // (name, date)
    {
        let name = realm.objects(DoneGameRealm.self).reversed()[id].accessToGame!.accessToName
        let date = realm.objects(DoneGameRealm.self).reversed()[id].accessToGame!.accessToDate
        
        return (name,date)
    }
    
    func getNamesOfTeamsOfGameById(id: Int) -> [String]
    {
        let myTeam = realm.objects(DoneGameRealm.self).reversed()[id].accessToGame!.accessToTeamA.accessToName
        let enemyTeam = realm.objects(DoneGameRealm.self).reversed()[id].accessToGame!.accessToTeamB.accessToName
        return [myTeam, enemyTeam]
    }
    func deleteGame(name: String)
    {
        
        for item in realm.objects(DoneGameRealm.self) where item.accessToGame!.accessToName == name
        {
            try! realm.write
            {
                realm.delete(item)
            }
        }
    }
    
    func addNameOfWatchedGame(name: String)
    {
        let object = NameOfGameForWatchingRealm()
        object.accessToName = name
        
        try! realm.write
        {
            if realm.objects(NameOfGameForWatchingRealm.self).count < 1
            {
                realm.add(object)
            }
            else
            {
                let pastName = realm.objects(NameOfGameForWatchingRealm.self).first
                pastName?.accessToName = object.accessToName
            }
            
        }
    }
    
    func getStat(nameOfGame: String) -> [[String]]
    {
        var game = DoneGame()
//        var currentZone = 0
//        var points = 0
//        // [Total, 1,2,3,4...14]
//        var stats = Array(repeating: StatisticsByZone(), count: 15)
        var statString = [[String]]()
        
        
        
        for item in games where item.accessToGame!.accessToName == nameOfGame
        {
            game = item.accessToGame!
        }
//
//        for attack in game.accessToAttacks where attack.accessToTeamA == true
//        {
//            currentZone = attack.accessToZone
//            stats[currentZone].total += 1
//            stats[0].total += 1
//            if attack.accessToResult
//            {
//                stats[currentZone].made += 1
//                stats[0].made += 1
//
//                points = (currentZone < 6 ? (3) : (2))
//                stats[currentZone].score += points
//                stats[0].score += points
//            }
//        }
//
//        for i in 0...14
//        {
//
//            if stats[i].total == 0
//            {
//                // "Sector","Made","Total","%","Score","% score","% all shots"
//                statString.append(["\(i)", "\(stats[i].made)", "\(stats[i].total)", "\(stats[i].percent)", "\(stats[i].score)", "\(stats[i].percentScore)", "\(stats[i].percentShots)"])
//                continue
//            }
//            stats[i].percent = Float(stats[i].made) / Float(stats[i].total) * 100
//            stats[i].percentScore = Float (stats[i].score) / Float(stats[0].score) * 100
//            stats[i].percentShots = Float(stats[i].total) / Float(stats[0].total) * 100
//            // "Sector","Made","Total","%","Score","% score","% all shots"
//            statString.append(["\(i)", "\(stats[i].made)", "\(stats[i].total)", "\(stats[i].percent)", "\(stats[i].score)", "\(stats[i].percentScore)", "\(stats[i].percentShots)"])
//        }
//
//        statString[0][0] = "Total"
//        let total = statString.removeFirst()
//        statString.append(total)
        /*
         получается для обеих команд по табличке в одном файле.
         В каждой таблице по 4 колонки в таком порядке:
         номер атаки, действие, игрок, зона
         */
        // my team
        
        var i = 1;
        statString.append([game.accessToTeamA.accessToName])
        for item in game.accessToAttacks where item.accessToTeamA == true
        {
            statString.append(["\(i)", "\(item.accessToResult ? "Win" : "Lose")", "\(item.accessToPlayer)", "\(item.accessToZone)"])
            i += 1;
        }
        
        // enemy team
        i = 1;
        for item in game.accessToAttacks where item.accessToTeamA == false
        {
            statString.append([" "])
            statString.append([game.accessToTeamB.accessToName])
            break
        }
        for item in game.accessToAttacks where item.accessToTeamA == false
        {
            statString.append(["\(i)", "\(item.accessToResult ? "Win" : "Lose")", "\(item.accessToPlayer)", "\(item.accessToZone)"])
            i += 1;
        }
        
        
                return statString
    }
}

