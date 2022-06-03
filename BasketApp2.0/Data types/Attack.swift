//
//  Attack.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import UIKit
import RealmSwift
class Attack: Codable
{
    
    private var time: Int
    private var player: String
    private var zone: Int
    private var teamA: Bool
    private var result: Bool
    
    init(time: Int, player: String, zone: Int, result: Bool, teamA: Bool)
    {
        self.time = time
        self.player = player
        self.zone = zone
        self.teamA = teamA
        self.result = result
    }
    
    enum TypeOfData
    {
        case time
        case player
        case zone
        case status
    }
    
//    func accessToData(typeOfData: TypeOfData)
//    {
//        switch typeOfData {
//        case .time:
//            return self.time
//        case .player:
//            return self.player
//        case .zone:
//            return self.zone
//        case .status:
//            return self.status
//        }
//    }
    var accessToTime: Int
    {
        get
        {
            return self.time
        }
    }
    
    var accessToPlayer: String
    {
        get
        {
            return self.player
        }
    }
    
    var accessToZone: Int
    {
        get
        {
            return self.zone
        }
    }
    
    var accessToResult: Bool
    {
        get
        {
            return self.result
        }
    }
    
    var accessToTeamA: Bool
    {
        get
        {
            return self.teamA
        }
    }
    
}

