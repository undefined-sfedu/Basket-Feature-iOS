//
//  WatchGamePresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 07.03.2022.
//

import Foundation
import UIKit
class WatchGamePresenter
{
    private var model = WatchGameModel()
    private var view = UIViewController()
    enum Mode: String
    {
        case all = "all"
        case scored = "scored"
        case shot = "shots"
    }
    
    private var player = ""
    private var teamA: Bool? = nil
    private var time = -1
    private var mode: Mode? = nil
    
    func setView(view: UIViewController)
    {
        self.view = view
    }
    
    private func getWatchGameView() -> WatchGameView
    {
        guard let newView = view as? WatchGameView else{ return WatchGameView()}
        return newView
    }
    func setPlayer(teamA: Bool, player: String)
    {
        
        if self.player == player && self.teamA == teamA
        {
            self.player = ""
            self.teamA = nil
            getWatchGameView().turnTitleOfField(on: false)
        }
        else
        {
            self.teamA = teamA
            self.player = player
            getWatchGameView().turnTitleOfField(on: true)
        }
        doingByMode()
    }
    
    func setTime(time: Int)
    {
        self.time = time
        doingByMode()
    }
    
    func setMode(mode: String)
    {
        let smallMode = mode.lowercased()
        self.mode = Mode.init(rawValue: smallMode)
        doingByMode()
    }
    
    func doingByMode()
    {
        if time != -1 && mode != nil && teamA != nil
        {
            var stat = [String]()
            switch self.mode!
            {
            case Mode.all:
                stat = model.getAllScore(teamA: self.teamA!, player: self.player, time: self.time)
                break
                
            case Mode.scored:
                stat = model.getScoredScore(teamA: self.teamA!, player: self.player, time: self.time)
                break
                
            case Mode.shot:
                stat = model.getShotScore(teamA: self.teamA!, player: self.player, time: self.time)
                break
            }
            getWatchGameView().setTitlesOfScores(titles: stat)
        }
    }
    
    func getNameOfTeam(teamA: Bool) -> String
    {
        return model.getNameOfTeam(teamA: teamA)
    }
    
    func getCountOfPlayersInTeam(teamA: Bool) -> Int
    {
        return model.getCountOfPlayersInTeam(teamA: teamA)
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        
        return model.getNumOfPlayer(teamA: teamA, id: id)
    }
    
    func getSelectedPlayer() -> String
    {
        return self.player
    }
    
    func getSelectedTeam() -> Bool?
    {
        return self.teamA
    }
}
