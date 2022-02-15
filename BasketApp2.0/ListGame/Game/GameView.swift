//
//  Game.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import UIKit
import SnapKit
class GameView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    private var presenter = GamePresenter()
    
    private var height: CGFloat = 0
    private var width: CGFloat = 0
    
    private var field = Field()
    private var idCell = "idForCellInGame"
    private var time = UISegmentedControl.init(items: ["1", "2", "3", "4", "+"])
    private let controlOfModeOfPresenting = UISegmentedControl.init(items: ["input", "all", "scored", "shot", "end"])
    
    private var buttonTeamA = UIButton(type: .system)
    private var buttonTeamB = UIButton(type: .system)
    private var historyButton = UIButton(type: .system)
    
    private var tableTeamA = UITableView(frame: CGRect(), style: .insetGrouped)
    private var tableTeamB = UITableView(frame: CGRect(), style: .insetGrouped)
    
    
    //MARK: SET ORIENTATION
    override var shouldAutorotate: Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        
        return .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        
        return .landscapeRight
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        self.height = min(self.view.frame.height, self.view.frame.width)
        self.width = max(self.view.frame.height, self.view.frame.width)
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        for item in [tableTeamA, tableTeamB, field, buttonTeamA, buttonTeamB, time, controlOfModeOfPresenting, historyButton]
        {
            self.view.addSubview(item)
        }
        presenter.setView(view: self)
        
        setField()
        setSegmentedControlls()
        setTableViews()
        setHistoryButton()
        
    }
    
    //MARK: FUNCS FOR PRESENTER
    
    func changeColorOfSelectedPlayer(teamA: Bool, player: String)
    {
        for cell in (teamA ? (tableTeamA) : (tableTeamB)).visibleCells
        {
            if cell.textLabel?.text == player
            {
                cell.contentView.backgroundColor = .red
                break
            }
        }
    }
    
    func changeColorOfSelectedTeam(teamA: Bool)
    {
        (teamA ? (buttonTeamA) : (buttonTeamB)).backgroundColor = .red
    }
    
    func resetColorOfViewsOfPlayer()
    {
        for cells in [tableTeamA.visibleCells, tableTeamB.visibleCells]
        {
            for cell in cells
            {
                cell.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
            }
        }
    }
    
    func resetColorOfViewsOfTeams(color: UIColor)
    {
        for item in [buttonTeamA, buttonTeamB]
        {
            item.backgroundColor = color
        }
    }
    
    /// changeVisibleOfField - func for turn on/off labels of zones and repoint field in default colors
    /// - Parameter turnOn: turn on/or visible of field and its labels
    func changeVisibleElementsOfField(turnOn: Bool)
    {
        field.paintZoneByTap(point: CGPoint(x: -1, y: -1))
        field.isUserInteractionEnabled = !turnOn
        field.turnLabels(on: turnOn)
    }
    
    func changeTitleOfLabelOfField(titles: [String])
    {
        field.changeTitleOfLabels(score: titles)
    }
    
    func changeEnableForTeamButtons(turnOn: Bool)
    {
        for item in [buttonTeamA, buttonTeamB]
        {
            item.isEnabled = turnOn
            item.backgroundColor = (turnOn ? (UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)) : (.white))
        }
    }
    
    func changeMode(id: Int)
    {
        self.controlOfModeOfPresenting.selectedSegmentIndex = id
    }
    //MARK: SETTING VIEWS FUNCS
    private func setTableViews()
    {
        
        for item in [tableTeamA, tableTeamB]
        {
            item.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
            item.backgroundColor = .white
            item.delegate = self
            item.dataSource = self
            item.showsHorizontalScrollIndicator = false
            item.showsVerticalScrollIndicator = false
            item.sectionHeaderHeight = 0
            item.sectionFooterHeight = 10
            item.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
            item.frame.size = CGSize(width: field.frame.origin.x, height: field.frame.height)
            
            item.center = (item == tableTeamA) ? (CGPoint(x: field.frame.origin.x / 2, y: field.center.y)) : (CGPoint(x: self.width - (field.frame.origin.x / 2), y: field.center.y))

        }
        
        for item in [buttonTeamA, buttonTeamB]
        {
            item.setTitle(presenter.getNameOfTeam(teamA: item == buttonTeamA), for: .normal)
            item.setTitleColor(.black, for: .normal)
            item.backgroundColor = .white
            item.layer.cornerRadius = 10
            item.frame.size = CGSize(width: time.frame.origin.x * 0.9, height: time.frame.height)
            item.center = item == buttonTeamA ? (CGPoint(x: time.frame.origin.x/2, y: tableTeamA.frame.origin.y/2)) : (CGPoint(x: self.width - time.frame.origin.x/2, y: tableTeamA.frame.origin.y/2))
            item.addTarget(self, action: #selector(selectTeam(_:)), for: .touchDown)
            item.isEnabled = false
        }
    }
    
    private func setField()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(paintZone(_:)))
        field.addGestureRecognizer(tap)
        field.frame.size = CGSize(width: width * 6 / 8, height: width * 6 / 16)
        field.center = CGPoint(x: width / 2, y: height / 2)
        
    }
    
    private func setSegmentedControlls()
    {
        time.frame.size = CGSize(width: field.frame.width / 1.8, height: field.frame.minY * 0.4)
        time.center = CGPoint(x: field.center.x, y: field.frame.origin.y / 2)
        time.selectedSegmentIndex = 0
        time.addTarget(self, action: #selector(changeTime(_:)), for: .valueChanged)
        time.selectedSegmentTintColor = UIColor(red: 243/255, green: 51/255, blue: 155/255, alpha: 1)
        
        
        controlOfModeOfPresenting.frame.size = time.frame.size
        controlOfModeOfPresenting.center = CGPoint(x: time.center.x, y: self.height - time.center.y)
        controlOfModeOfPresenting.selectedSegmentIndex = 0
        controlOfModeOfPresenting.addTarget(self, action: #selector(changeMode(_:)), for: .valueChanged)
        controlOfModeOfPresenting.selectedSegmentTintColor = UIColor(red: 243/255, green: 51/255, blue: 155/255, alpha: 1)
    }
    
    private func setHistoryButton()
    {
        historyButton.frame.size = CGSize(width: 100, height: 50)
        historyButton.frame.origin = CGPoint(x: field.frame.maxX, y: controlOfModeOfPresenting.frame.origin.y )
        historyButton.setTitle("Histore", for: .normal)
        historyButton.backgroundColor = .systemRed
        historyButton.addTarget(self, action: #selector(goToHistory(_:)), for: .touchDown)
    }
    
    //MARK: OBJC FUNCS
    @objc func selectTeam(_ sender: UIButton)
    {
        presenter.setTeam(teamA: sender == buttonTeamA)
    }
    
    @objc func paintZone(_ sender: UITapGestureRecognizer)
    {
        field.paintZoneByTap(point: sender.location(in: field))
        presenter.setNumOfZone(zone: field.getNumOfPaintedZone())
    }
    
    @objc func changeTime(_ sender: UISegmentedControl)
    {
        presenter.setTime(time: sender.selectedSegmentIndex + 1)
    }
    
    @objc func changeMode(_ sender: UISegmentedControl)
    {
        presenter.setMode(mode: sender.selectedSegmentIndex)
    }
    
    @objc func goToHistory(_ sender: UIButton)
    {
        let historyView = presenter.getHistoryView()
//        self.present(historyView, animated: true, completion: nil)
        self.navigationController?.pushViewController(historyView, animated: true)
    }
    
    //MARK: SETTING TABLE VIEWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return presenter.getCountOfPlayers(teamA: tableView == tableTeamA )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        cell.textLabel!.text = presenter.getNumOfPlayer(teamA: tableView == tableTeamA, id: indexPath.section)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel!.textAlignment = .center
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.cellForRow(at: indexPath)!.contentView.backgroundColor = .red
        presenter.setPlayer(teamA: (tableView == tableTeamA), player: tableView.cellForRow(at: indexPath)!.textLabel!.text!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        
        tableView.cellForRow(at: indexPath)!.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        (tableView.frame.height/5 - tableView.sectionFooterHeight)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return view
    }
}


