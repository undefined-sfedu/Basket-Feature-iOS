//
//  WatchOneTeamView.swift
//  BasketApp2.0
//
//  Created by Daniil on 13.12.2021.
//

import UIKit

class WatchOneTeamView: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    private let presenter = WatchOneTeamPresenter()
    private let idOfCell = "playerId"
    private var tableOfPlayers = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        setTableView()
        self.view.addSubview(tableOfPlayers)
        setRightBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableOfPlayers.reloadData()
    }
    
    private func setView()
    {
        self.title = presenter.getNameOfTeam()
//        self.navigationItem.titleView?.isHidden = true
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
    }

    private func setTableView()
    {
        tableOfPlayers = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableOfPlayers.delegate = self
        tableOfPlayers.dataSource = self
        tableOfPlayers.backgroundColor = .white
        tableOfPlayers.register(CellWithTwoTitles.self, forCellReuseIdentifier: idOfCell)
        
    }
    
    private func setRightBarButtonItem()
    {
        let timeItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openViewOfAddingPlayer(_:)))
        self.navigationItem.rightBarButtonItem = timeItem
    }
    
    @objc func openViewOfAddingPlayer(_ sender: UIBarButtonItem)
    {
        let view = AddPlayerView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        let num = presenter.getNumOfPlayers()
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOfCell, for: indexPath) as! CellWithTwoTitles
        cell.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        cell.accessToLeftTitle = presenter.getNameOfPlayer(id: indexPath.section)
        cell.accessToRightTitle = presenter.getNumberOfPlayer(id: indexPath.section)
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        self.view.frame.height / 14
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.presenter.deleteTeam(id: indexPath.section)
            self.tableOfPlayers.reloadData()
        }
        
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        swipe.performsFirstActionWithFullSwipe = false
        return swipe
    }
}
