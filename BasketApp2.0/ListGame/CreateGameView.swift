//
//  CreateGameView.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.12.2021.
//

import UIKit
import SnapKit
class CreateGameView: UIViewController, UIGestureRecognizerDelegate
{
    private let presenter = CreateGamePresenter()
    
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    
    private var nameTextField = UITextField()
    private var teamALabel = UILabel()
    private var teamBLabel = UILabel()
    private var createGameButton = UIButton()
    
    enum typeOfMistake
    {
        case identicalTeams
        case emptyNameOfTeam
        case identicalGames
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        presenter.setView(view: self)
        setSizeVariables()
        for item in [nameTextField, teamALabel, teamBLabel, createGameButton]
        {
            self.view.addSubview(item)
        }
        setPositionOfViews(ratioAndView: [3: nameTextField, 4.3: teamALabel, 5.6: teamBLabel, 11: createGameButton])
        setFields(fields: [nameTextField, teamALabel, teamBLabel])
        setLabels(labels: [teamALabel, teamBLabel])
        setCreateGameButton()
    }
    
    @objc func markTeamA(_ sender: UITapGestureRecognizer)
    {
        let showTeamsView = presenter.markTeam(teamA: true)
        presentShowTeamView(showTeamsView: showTeamsView)
    }
    
    @objc func markTeamB(_ sender: UITapGestureRecognizer)
    {
        let showTeamsView = presenter.markTeam(teamA: false)
        presentShowTeamView(showTeamsView: showTeamsView)
    }
    
    func presentShowTeamView(showTeamsView: ShowTeamView)
    {
        showTeamsView.setGameView(view: self)
        let navView = UINavigationController(rootViewController: showTeamsView)
        present(navView, animated: true, completion: nil)
    }
    
    func setTeam(nameOfTeam: String)
    {
        presenter.setTeam(nameOfTeam: nameOfTeam)
    }
    
    func updateLabelsOfTeams(nameOfTeam: String, teamA: Bool)
    {
        teamA ? (teamALabel.text = nameOfTeam) : (teamBLabel.text = nameOfTeam)
    }
    
    private func setView()
    {
        self.title = "Create game"
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
    }
    
    private  func setSizeVariables()
    {
        heightForFields = self.view.frame.height / 14
        widthForFields = self.view.frame.width * 0.9
    }
    
    private func setPositionOfViews(ratioAndView: [Double:UIView])
    {
        for (key, value) in ratioAndView
        {
            value.layer.cornerRadius = 14
            value.snp.makeConstraints
            {
                maker in
                maker.width.equalTo(widthForFields)
                maker.height.equalTo(heightForFields)
                maker.centerX.equalToSuperview()
                maker.topMargin.equalTo(key * heightForFields)
            }
        }
    }
    
    private func setFields(fields: [UIView])
    {
        for item in fields
        {
            item.layer.borderWidth = 1
            item.layer.borderColor = UIColor.black.cgColor
        }
        nameTextField.placeholder = "Name"
    }
    
    private func setLabels(labels: [UILabel])
    {
        let texts = ["Choose your team A", "Choose enemy's team B"]
        
        let tapTeamA = UITapGestureRecognizer(target: self, action: #selector(markTeamA(_:)))
        let tapTeamB = UITapGestureRecognizer(target: self, action: #selector(markTeamB(_:)))
        
        for i in 0...labels.count - 1
        {
            labels[i].text = texts[i]
            labels[i].isUserInteractionEnabled = true
            labels[i] == teamALabel ? ( labels[i].addGestureRecognizer(tapTeamA)) : ( labels[i].addGestureRecognizer(tapTeamB))
        }
    }
    
    private func setCreateGameButton()
    {
        createGameButton.backgroundColor = UIColor(red: 253/255, green: 121/255, blue: 192/255, alpha: 1)
        createGameButton.setTitle("Let's begin", for: .normal)
        createGameButton.titleLabel?.attributedText = NSAttributedString(string: "Let's begin", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        createGameButton.setTitleColor(.black, for: .normal)
        createGameButton.addTarget(self, action: #selector(createGame(_:)), for: .touchDown)
    }
    
    func alertAboutWrongInfo(typeOfMistake: typeOfMistake)
    {
        let alert = UIAlertController(title: "Attention", message: "", preferredStyle: .alert)
        
        switch typeOfMistake {
        case .identicalTeams:
            alert.message = "You have chosen identical teams"
        case .emptyNameOfTeam:
            alert.message = "You haven't chosen one of teams"
        case .identicalGames:
            alert.message = "Game with this name are in your games"
        }
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func createGame(_ sender: UIButton)
    {
        presenter.createGame(name: nameTextField.text!)
    }
    
    func letsBeginGame()
    {
        let view = GameView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
