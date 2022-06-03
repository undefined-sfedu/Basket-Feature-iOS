//
//  TeamsView.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import SnapKit
class TeamsView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private let presenter = TeamsPresenter()
    private var idCell = "teamCell"
    private var tableOfTeams = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setTableOfTeams()
        self.view.addSubview(tableOfTeams)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        setView()
        tableOfTeams.reloadData()
    }
    
    func setView()
    {
        self.title = "Teams"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"), style: .plain, target: self, action: #selector(openViewOfCreatingTeams(_:)))
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setTableOfTeams()
    {
        tableOfTeams = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableOfTeams.dataSource = self
        tableOfTeams.delegate = self
        tableOfTeams.backgroundColor = .white
        tableOfTeams.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
    }
    
    @objc func openViewOfCreatingTeams(_ sender:UIBarButtonItem )
    {
        let view = CreateTeamsView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    //MARK: SET TABLE OF TEAMS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return presenter.getCountOfTeams()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.backgroundColor = UIColor(red: 243/255, green: 51/255, blue: 155/255, alpha: 1)
        cell.textLabel?.attributedText = NSAttributedString(string: presenter.getNameOfTeamWithSpecialId(id: indexPath.section), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.view.frame.height / 14
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.saveTeamForAddingPLayer(id: indexPath.section)
        let view = WatchOneTeamView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let cell = tableView.cellForRow(at: indexPath)
            let name = cell?.textLabel!.text
            self.presenter.deleteTeam(name: name!)
            self.tableOfTeams.reloadData()
        }
        
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        swipe.performsFirstActionWithFullSwipe = false
        return swipe
    }
}
