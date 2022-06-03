//
//  GamePresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import UIKit

class GamePresenter
{
    enum Mode: Int
    {
        case input = 0
        case all
        case scored
        case shot
        case end
    }
    
    private var view = UIViewController()
    private var model = GameModel()
    private var currentTeamA: Bool? = nil
    private var currentPlayer: String = ""
    private var currentMode: Mode = .input
    private var currentTime: Int = 1
    private var currentZone: Int = 0
    private var lastSelectedIndexByMode: Mode = .input
    
    //MARK: FUNCS SETTING VALUES
    func setView(view: GameView)
    {
        self.view = view
    }
    
    func setNumOfZone(zone: Int)
    {
        self.currentZone = zone
        doingByMode()
    }
    
    func setTime(time: Int)
    {
        self.currentTime = time
        doingByMode()
    }
    
    
    
    func setPlayer(teamA: Bool, player: String)
    {
        
        if player == self.currentPlayer && teamA == self.currentTeamA
        {
            self.currentTeamA = nil
            self.currentPlayer = ""
        }
        else
        {
            self.currentTeamA = teamA
            self.currentPlayer = player
        }
        
        if let newView = view as? GameView
        {
            newView.resetColorOfViewsOfPlayer()
            if self.currentPlayer != ""
            {
                newView.changeColorOfSelectedPlayer(teamA: teamA, player: currentPlayer)
                newView.resetColorOfViewsOfTeams(color: currentMode == .input ? (.white) : (UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)))
            }
            else
            {
            newView.resetColorOfViewsOfTeams(color: currentMode == .input ? (.white) : (UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)))
            newView.changeColorOfSelectedTeam(teamA: currentTeamA)
            }
        }
        
        
        
        print("Current Player - \(currentPlayer)")
        
        doingByMode()
    }
    
    func getHistoryView() -> HistoryView
    {
        model.saveAttacksInLocalMemory()
        return HistoryView()
    }
    
//    func setTeam(teamA: Bool)
//    {
//        if teamA == self.currentTeamA
//        {
//            self.currentTeamA = nil
//        }
//        else
//        {
//            self.currentTeamA = teamA
//        }
//        
//        if let newView = view as? GameView
//        {
//            newView.resetColorOfViewsOfPlayer()
//            newView.resetColorOfViewsOfTeams(color: currentMode == .input ? (.white) : (UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)))
//            newView.changeColorOfSelectedTeam(teamA: currentTeamA)
//        }
//        doingByMode()
//        print()
//        print("Current Team - \(currentTeamA)")
//    }
    
    func setMode(mode: Int)
    {
        
        if let newView = view as? GameView
        {
            newView.changeVisibleElementsOfField(turnOn: mode != Mode.input.rawValue)
            if mode * currentMode.rawValue == 0
            {
                newView.changeEnableForTeamButtons(turnOn: (mode != Mode.input.rawValue))
            }
        }
        self.lastSelectedIndexByMode = self.currentMode
        self.currentMode = Mode.init(rawValue: mode)!
        
        if mode != Mode.input.rawValue
        {
            self.currentZone = 0
        }
        doingByMode()
    }
    
    private func doingByMode()
    {
//        if let newView = self.view as? GameView
//        {
//            newView.resetColorOfViewsOfTeams()
//        }
        switch (currentMode)
        {
        case .input:
            inputScore()
            
        case .all:
            getAllScore()
        case .scored:
            getScoredScore()
        case .shot:
            getShotScore()
        case .end:
            endGame()
        }
    }
    
    // MARK: DOING BY MODE
    private func inputScore()
    {
        if currentZone != 0 && self.currentPlayer != ""
        {
            view.present(getAlert(), animated: true, completion: nil)
            
        }
        
    }
    
    private func getAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Input", message: "Enter result of shot", preferredStyle: .alert)
        let win = UIAlertAction(title: "Win", style: .default) {  [self] UIAlertAction in
            
            model.inputAttack(teamA: currentTeamA!, numOfPlayer: currentPlayer, result: true, time: currentTime, zone: currentZone)
            self.setPlayer(teamA: self.currentTeamA!, player: self.currentPlayer)
            getView().resetField()
            self.currentZone = 0
        }
        
        let no = UIAlertAction(title: "Lose", style: .default) {  [self] UIAlertAction in
            
            model.inputAttack(teamA: currentTeamA!, numOfPlayer: currentPlayer, result: false, time: currentTime, zone: currentZone)
            self.setPlayer(teamA: self.currentTeamA!, player: self.currentPlayer)
            getView().resetField()
            self.currentZone = 0
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(win)
        alert.addAction(no)
        alert.addAction(cancel)
        
        return alert
    }
    
    private func getView() -> GameView
    {
        guard let newView = view as? GameView else {return GameView()}
        return newView
    }
    
    private func getAllScore()
    {
        if let newView = view as? GameView
        {
            if let team = self.currentTeamA
            {
                let titles = model.getAllScore(teamA: team, player: self.currentPlayer, time: self.currentTime)
                newView.changeTitleOfLabelOfField(titles: titles)
            }
            
            
        }
        
    }
    
    private func getScoredScore()
    {
        if let newView = view as? GameView
        {
            if let team = self.currentTeamA
            {
                let titles = model.getScoredScore(teamA: team, player: self.currentPlayer, time: self.currentTime)
                newView.changeTitleOfLabelOfField(titles: titles)
            }
        }
    }
    
    private func getShotScore()
    {
        if let newView = view as? GameView
        {
            if let team = self.currentTeamA
            {
                let titles = model.getShotScore(teamA: team, player: self.currentPlayer, time: self.currentTime)
                newView.changeTitleOfLabelOfField(titles: titles)
            }
        }
    }
    
    private func endGame()
    {
        view.present(exitAlert(), animated: true, completion: nil)
    }
    
    private func exitAlert() -> UIAlertController
    {
        let alert = RotationAlertController(title: "Warning", message: "Are you sure you wanna leave game?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { UIAlertAction in
            self.model.saveGame()
            
            self.view.navigationController?.viewControllers = [ListGameView()]
            self.view.navigationController?.popToRootViewController(animated: true)
        }
        let no = UIAlertAction(title: "No", style: .default) { [self] UIAlertAction in
            self.setMode(mode: lastSelectedIndexByMode.rawValue)
            if let newView = view as? GameView
            {
                newView.changeMode(id: self.currentMode.rawValue)
            }
        }
        

        
        alert.addAction(yes)
        alert.addAction(no)
        
        return alert
    }
    
    // MARK: FUNCS RETURNING SOME VALUES FOR VIEW
    func getCountOfPlayers(teamA: Bool) -> Int
    {
        return model.getCountOfPlayers(teamA: teamA)
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        return model.getNumOfPlayer(teamA: teamA, id: id)
    }
    
    func getNameOfTeam(teamA:Bool) -> String
    {
        model.getNameOfTeam(teamA: teamA)
    }
    
    func getSelectedTeam() -> Bool?
    {
        return currentTeamA
    }
    
    func getSelectedPlayer() -> String
    {
        return currentPlayer
    }
    
    func getCurrentMode() -> Mode
    {
        return currentMode
    }

    
}
