//
//  WatchGameModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 07.03.2022.
//

import RealmSwift
class WatchGameModel
{
    private var realm: Realm
    private var game = DoneGame()
    
    init()
    {
        self.realm = try! Realm()
        findGame()
        print(game.accessToName)
    }
    
    private func findGame()
    {
        let name = realm.objects(NameOfGameForWatchingRealm.self).first!.accessToName
        for item in realm.objects(DoneGameRealm.self)
        {
            if item.accessToGame!.accessToName == name
            {
                self.game = item.accessToGame!
                break
            }
        }
    }
    
    func getNameOfTeam(teamA: Bool) -> String
    {
        return teamA ? (game.accessToTeamA.accessToName) : (game.accessToTeamB.accessToName)
    }
    
    func getCountOfPlayersInTeam(teamA: Bool) -> Int
    {
        return teamA ? (game.accessToTeamA.getNumOfPlayers) : (game.accessToTeamB.getNumOfPlayers)
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        
        return teamA ? (game.accessToTeamA.getInfoAboutPlayers(id: id, typeOfInfo: .number)) : (game.accessToTeamB.getInfoAboutPlayers(id: id, typeOfInfo: .number))
    }
    
    func getAllScore(teamA: Bool, player: String, time: Int) -> [String]
    {
        var titles: [String] = Array.init(repeating: "", count: 14)
        //(win shots,all shots in current zone)
        var score: [(Int,Int)] = Array.init(repeating: (0,0), count: 14)
        
        if player != ""
        {
            for item in game.accessToAttacks where item.accessToTeamA == teamA && item.accessToTime == time && item.accessToPlayer == player
            {
                score[item.accessToZone - 1].1 += 1
                if item.accessToResult {score[item.accessToZone - 1].0 += 1}
            }
        }
        else
        {
            for item in game.accessToAttacks where item.accessToTeamA == teamA && item.accessToTime == time
            {
                score[item.accessToZone - 1].1 += 1
                if item.accessToResult {score[item.accessToZone - 1].0 += 1}
            }
        }
        var win: Int = 0
        var all: Int = 0
        var percent: Double = 0
        
        for i in 0...titles.count-1
        {
            win = score[i].0
            all = score[i].1
            percent = (all == 0) ? (0) : (Double(win)/Double(all) * 100)
            titles[i] = "\(win)/\(all)\n\(String(format: "%.2f", percent))%"
        }
        return titles
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
            for item in game.accessToAttacks where item.accessToTeamA == teamA && item.accessToTime == time && item.accessToPlayer == player && item.accessToResult
            {
                
                points = (item.accessToZone >= 1 && item.accessToZone <= 5) ? (3) : (2)
                all += points
                scoreByZones[item.accessToZone - 1] += points
            }
        }
        else
        {
            for item in game.accessToAttacks where item.accessToTeamA == teamA && item.accessToTime == time && item.accessToResult
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
            for item in game.accessToAttacks where item.accessToPlayer == player && item.accessToTeamA == teamA && item.accessToTime == time
            {
                all += 1
                scoreByZones[item.accessToZone - 1] += 1
            }
        }
        else
        {
            for item in game.accessToAttacks where item.accessToTeamA == teamA && item.accessToTime == time
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
    
}

