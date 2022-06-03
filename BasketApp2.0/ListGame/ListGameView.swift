//
//  GamesView.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import UniformTypeIdentifiers
class ListGameView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentPickerDelegate
{
    private var idCell = "gameCell"
    private var tableOfGames = UITableView()
    private var presenter = ListGamePresenter()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        changeOrientation()
        
        
    }
   
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setView()
        setTableOfGames()
        tableOfGames.reloadData()
    }
    
    private func changeOrientation()
    {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    private func setView()
    {
        self.title = "Games"
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"), style: .done, target: self, action: #selector(createGame(_:)))
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func createGame(_ sender: UIBarButtonItem)
    {
        let view = CreateGameView()
//        view.setGameView(view: self)
//        view.setTeams(teams: ["team1", "team2", "team3"])
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func setTableOfGames()
    {
       
        tableOfGames = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableOfGames.dataSource = self
        tableOfGames.showsVerticalScrollIndicator = false
        tableOfGames.delegate = self
        tableOfGames.backgroundColor = .white
        tableOfGames.register(CellWithTwoTitles.self, forCellReuseIdentifier: idCell)
        if self.view.subviews.isEmpty
        {
            self.view.addSubview(tableOfGames)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        print(presenter.getCountOfGames())
        return presenter.getCountOfGames()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! CellWithTwoTitles
        cell.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        let dataOfGame = presenter.getNameAndDateOfGameById(id: indexPath.section)
        cell.accessToLeftTitle = dataOfGame.0
        cell.accessToRightTitle = dataOfGame.1
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.view.frame.height / 14
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CellWithTwoTitles
        presenter.addNameOfWatchedGame(name: cell.accessToLeftTitle )
        self.navigationController?.pushViewController(WatchGameView(), animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        
        let delete = UIContextualAction(style: .destructive, title: "Get CSV") { (action, view, success) in
            let cell = tableView.cellForRow(at: indexPath) as! CellWithTwoTitles
            let nameOfSelectedGame = cell.accessToLeftTitle
            let dateOfSelectedGame = cell.accessToRightTitle
            self.presenter.generateCSVFile(nameOfGame: nameOfSelectedGame, date: dateOfSelectedGame, idOfCell: indexPath.section)
            self.importCSV()
        }


        let swipe = UISwipeActionsConfiguration(actions: [delete])
        swipe.performsFirstActionWithFullSwipe = false
        return swipe
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let cell = tableView.cellForRow(at: indexPath) as! CellWithTwoTitles
            let nameOfSelectedGame = cell.accessToLeftTitle
            
            self.presenter.deleteGame(name: nameOfSelectedGame)
            self.tableOfGames.reloadData()
        }
        
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        swipe.performsFirstActionWithFullSwipe = false
        return swipe
    }
    
    func importCSV()
    {
        let supportedFiles: [UTType] = [UTType.data]
        
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: supportedFiles, asCopy: true)
        controller.delegate = self
        controller.allowsMultipleSelection = false
        
        present(controller, animated: true, completion: nil)
    }
    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])
//    {
//
//    }
    
}

