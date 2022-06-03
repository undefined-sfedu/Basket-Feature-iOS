//
//  GamesPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import RealmSwift
class ListGamePresenter
{
    private var model = ListGameModel()
    
    func getCountOfGames() -> Int
    {
        model.getCountOfGames()
    }
    
    func getNameAndDateOfGameById(id: Int) -> (String, String)
    {
        return model.getNameAndDateOfGameById(id: id)
    }
    
    func deleteGame(name: String)
    {
        model.deleteGame(name: name)
    }
    
    func addNameOfWatchedGame(name: String)
    {
        model.addNameOfWatchedGame(name: name)
    }
                                            
    //teams = [myTeamName, EnemyTeamName]
    func generateCSVFile(nameOfGame: String, date: String, idOfCell: Int)
    {
        let stat = model.getStat(nameOfGame: nameOfGame)
        let teamsNames = model.getNamesOfTeamsOfGameById(id: idOfCell)
        
        let fileName = "\(teamsNames[0]) - \(teamsNames[1]) \(date).csv"
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let docURl = URL(fileURLWithPath: docPath).appendingPathComponent(fileName)
        
        let output = OutputStream.toMemory()
        
        
        let csvWriter = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        
        csvWriter?.writeField(nameOfGame)
        
        csvWriter?.writeField(date)
        csvWriter?.finishLine()
        
        csvWriter?.writeField("\(teamsNames[0]) - \(teamsNames[1])")
        csvWriter?.finishLine()
        
        let headers = ["Attack","Result","Player","Zone"]
        
        for item in headers
        {
            csvWriter?.writeField(item)
        }
        csvWriter?.finishLine()
        
        for line in stat
        {
            for value in line
            {
                csvWriter?.writeField(value)
            }
            csvWriter?.finishLine()
        }
        
        csvWriter?.closeStream()
        
        let buffer = (output.property(forKey: .dataWrittenToMemoryStreamKey)as? Data)
        do{
            try buffer?.write(to: docURl)
        }
        catch
        {
            
        }
        
    }
    
}
