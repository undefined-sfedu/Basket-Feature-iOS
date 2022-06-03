//
//  Game.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.12.2021.
//

import RealmSwift
import Foundation
class CurrentGame: Codable
{
    private var name: String
    private let teamA: Team // coach's team
    private let teamB: Team // enemy's team
    private var attacks = [Attack]()
    
    init(teamA: Team, teamB: Team, name: String)
    {
        self.teamA = teamA
        self.teamB = teamB
        self.name = name
    }
    
    var accessToTeamA: Team
    {
        get
        {
            return teamA
        }
    }
    
    var accessToTeamB: Team
    {
        get
        {
            return teamB
        }
    }
    
    var accessToName: String
    {
        get
        {
            return name
        }
    }
    
    var accessToAttacks: [Attack]
    {
        get
        {
            return attacks
        }
        set
        {
            attacks = newValue
        }
    }
}

class CurrentGameRealm: Object
{
    @objc private dynamic var classData: Data? = nil
    
    var accessToGame: CurrentGame?
    {
        get
        {
            if let gameData = classData
            {
                return try? JSONDecoder().decode(CurrentGame.self, from: gameData)
            }
            else
            {
                return nil
            }
        }
        set
        {
            classData = try? JSONEncoder().encode(newValue)
        }
    }
}

class DoneGame: Codable
{
    private var name: String
    private let teamA: Team // coach's team
    private let teamB: Team // enemy's team
    private var attacks = [Attack]()
    private var date = ""
    
    init()
    {
        self.name = ""
        self.teamA = Team()
        self.teamB = Team()
    }
    
    init(game: CurrentGame, attacks: [Attack], date: String)
    {
        self.name = game.accessToName
        self.teamA = game.accessToTeamA
        self.teamB = game.accessToTeamB
        self.attacks = attacks
        self.date = date
    }
    
    var accessToTeamA: Team
    {
        get
        {
            return teamA
        }
    }
    
    var accessToTeamB: Team
    {
        get
        {
            return teamB
        }
    }
    
    var accessToName: String
    {
        get
        {
            return name
        }
    }
    var accessToDate: String
    {
        get
        {
            return self.date
        }
    }
    
    var accessToAttacks: [Attack]
    {
        get
        {
            return attacks
        }
    }
    
}

class DoneGameRealm: Object
{
    @objc private dynamic var classData: Data? = nil
    
    var accessToGame: DoneGame?
    {
        get
        {
            if let gameData = classData
            {
                return try? JSONDecoder().decode(DoneGame.self, from: gameData)
            }
            else
            {
                return nil
            }
        }
        set
        {
            classData = try? JSONEncoder().encode(newValue)
        }
    }
}

class NameOfGameForWatchingRealm: Object
{
    @objc private dynamic var nameOfTeam: String  = ""
    
    var accessToName: String
    {
        get
        {
            return nameOfTeam
        }
        set
        {
            nameOfTeam = newValue
        }
    }
}

