//
//  GameModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import RealmSwift
//import Darwin
class GameModel
{
    
    private let realm: Realm
    private var game: CurrentGame
    private var attacks = [Attack]()
    
    init()
    {
        self.realm = try! Realm()
        self.game = realm.objects(CurrentGameRealm.self).first!.accessToGame!
    }
    
    func getCountOfPlayers(teamA: Bool) -> Int
    {
        return (teamA ? (self.game.accessToTeamA.getNumOfPlayers) : (self.game.accessToTeamB.getNumOfPlayers) )
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        return (teamA ? (self.game.accessToTeamA.getInfoAboutPlayers(id: id, typeOfInfo: .number)) : (self.game.accessToTeamB.getInfoAboutPlayers(id: id, typeOfInfo: .number)))
    }
    
    func getNameOfTeam(teamA:Bool) -> String
    {
        return teamA ? (game.accessToTeamA.accessToName) :(game.accessToTeamB.accessToName)
    }
    
    func inputAttack(teamA: Bool, numOfPlayer: String, result: Bool, time: Int, zone: Int)
    {
        let shot = Attack(time: time, player: numOfPlayer, zone: zone, result: result, teamA: teamA)
//        self.attacks.append(shot)
        self.attacks.insert(shot, at: 0)
    }
    
    func getAllScore(teamA: Bool, player: String, time: Int) -> [String]
    {
        var score: [String] = Array.init(repeating: "", count: 14)
        //(win shots,all shots in current zone)
        var scoreByZones: [(Int,Int)] = Array.init(repeating: (0,0), count: 14)
        
        if player != ""
        {
            for item in attacks where item.accessToTeamA == teamA && item.accessToTime == time && item.accessToPlayer == player
            {
                scoreByZones[item.accessToZone - 1].1 += 1
                if item.accessToResult {scoreByZones[item.accessToZone - 1].0 += 1}
            }
        }
        else
        {
            for item in attacks where item.accessToTeamA == teamA && item.accessToTime == time
            {
                scoreByZones[item.accessToZone - 1].1 += 1
                if item.accessToResult {scoreByZones[item.accessToZone - 1].0 += 1}
            }
        }
        var win: Int = 0
        var all: Int = 0
        var percent: Double = 0
        
        for i in 0...score.count-1
        {
            win = scoreByZones[i].0
            all = scoreByZones[i].1
            percent = (all == 0) ? (0) : (Double(win)/Double(all) * 100)
            score[i] = "\(win)/\(all)\n\(String(format: "%.2f", percent))%"
        }
        return score
    }
    
    func getScoredScore(teamA: Bool, player: String, time: Int) -> [String]
    {
        var score: [String] = Array.init(repeating: "", count: 14)
        var points = 0
        // (points in this zones/ points by all time)
        var scoreByZones: [(Int)] = Array.init(repeating: 0, count: 14)
        
        var all: Int = 0
        var percent: Double = 0
        
        if player != ""
        {
            for item in attacks where item.accessToTeamA == teamA && item.accessToTime == time && item.accessToPlayer == player && item.accessToResult
            {
                
                points = (item.accessToZone >= 1 && item.accessToZone <= 5) ? (3) : (2)
                all += points
                scoreByZones[item.accessToZone - 1] += points
            }
        }
        else
        {
            for item in attacks where item.accessToTeamA == teamA && item.accessToTime == time && item.accessToResult
            {
                points = (item.accessToZone >= 1 && item.accessToZone <= 5) ? (3) : (2)
                all += points
                scoreByZones[item.accessToZone - 1] += points
            }
        }
        for i in 0...score.count-1
        {
            percent = (scoreByZones[i] == 0) ? (0) : (Double(scoreByZones[i]) / Double(all) * 100)
            score[i] = "\(scoreByZones[i])/\(all)\n\(String(format: "%.2f", percent))%"
        }
        
        return score
    }
    
    func getShotScore(teamA: Bool, player: String, time: Int) -> [String]
    {
        var score: [String] = Array.init(repeating: "", count: 14)
        //(shots in this zones, shots by all time)
        var scoreByZones: [(Int)] = Array.init(repeating: 0, count: 14)
        
        var all = 0
        var percent: Double = 0
        if player != ""
        {
            for item in attacks where item.accessToPlayer == player && item.accessToTeamA == teamA && item.accessToTime == time
            {
                all += 1
                scoreByZones[item.accessToZone - 1] += 1
            }
        }
        else
        {
            for item in attacks where item.accessToTeamA == teamA && item.accessToTime == time
            {
                all += 1
                scoreByZones[item.accessToZone - 1] += 1
            }
        }
        for i in 0...score.count-1
        {
            percent = (scoreByZones[i] == 0) ? (0) : (Double(scoreByZones[i]) / Double(all) * 100)
            score[i] = "\(scoreByZones[i])/\(all)\n\(String(format: "%.2f", percent))%"
        }
        
        return score
    }
    
    func saveGame()
    {
        let calendar = Calendar.current
        let date = Date()
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        print(realm.objects(DoneGameRealm.self).count)
        let doneGame = DoneGame(game: self.game, attacks: self.attacks, date: "\(day).\(month).\(year)")
        let object = DoneGameRealm()
        object.accessToGame = doneGame
        try! realm.write
        {
            realm.add(object)
        }
    }
    
   
    
    func saveAttacksInLocalMemory()
    {
        try! realm.write
        {
            let game = realm.objects(CurrentGameRealm.self).first!.accessToGame!
            game.accessToAttacks = self.attacks
            realm.objects(CurrentGameRealm.self).first!.accessToGame = game
            
        }
    }
    
    func getUpdatedAttacks()
    {
        
        try! realm.write
        {
            self.attacks = realm.objects(CurrentGameRealm.self).first!.accessToGame!.accessToAttacks 
        }
    }
}
