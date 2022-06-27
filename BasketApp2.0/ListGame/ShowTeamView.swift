//
//  CreateGameView.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.12.2021.
//


import UIKit
class ShowTeamView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private var teams = [String]()
    private var tableOfTeams = UITableView()
    private var idCell = "cellForChooseTeam"
    private var gameView = UIViewController()
    
    
    func setGameView(view: UIViewController)
    {
        self.gameView = view
    }
    
    func setTeams(teams: [String])
    {
        self.teams = teams
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Teams"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setTableOfTeams()
    }
    
    func setTableOfTeams()
    {
        tableOfTeams = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableOfTeams.backgroundColor = .white
        tableOfTeams.delegate = self
        tableOfTeams.dataSource = self
        tableOfTeams.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
        self.view.addSubview(tableOfTeams)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell)!
        cell.textLabel?.text = teams[indexPath.section]
        cell.textLabel?.attributedText = NSAttributedString(string: teams[indexPath.section], attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
//        logInButton.titleLabel?.attributedText = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        cell.backgroundColor = UIColor(red: 243/255, green: 51/255, blue: 155/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let nameOfTeam = cell!.textLabel!.text!
        print("WAS SELECTED TEAM - \(nameOfTeam)")
        if let newView = gameView as? CreateGameView
        {
            newView.setTeam(nameOfTeam: nameOfTeam)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
