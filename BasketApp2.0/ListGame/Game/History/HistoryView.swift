//
//  HistoryView.swift
//  BasketApp2.0
//
//  Created by Daniil on 14.02.2022.
//

import UIKit
import SnapKit
class HistoryView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private var selectTeamControl = UISegmentedControl.init(items: ["",""])
    private var tableOfShots = UITableView(frame: CGRect(), style: .insetGrouped)
    private var presenter = HistoryPresenter()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        
        for item in [selectTeamControl, tableOfShots]
        {
            self.view.addSubview(item)
        }
        
        setView()
        setSegmentControl()
        setTableOfShots()
    }
    
    func setView()
    {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "History"
    }
    
    func setSegmentControl()
    {
        selectTeamControl.snp.makeConstraints
        {
            make in
            make.width.equalTo(self.view.frame.width * 0.9)
            make.height.equalTo(self.view.frame.height * 0.1)
            make.topMargin.equalTo(10)
            make.centerX.equalToSuperview()
        }
        
        let names = presenter.getNamesOfTeam()
        selectTeamControl.selectedSegmentTintColor = UIColor(red: 243/255, green: 51/255, blue: 155/255, alpha: 1)
        selectTeamControl.setTitle(names[0], forSegmentAt: 0)
        selectTeamControl.setTitle(names[1], forSegmentAt: 1)
        selectTeamControl.selectedSegmentIndex = 0
        selectTeamControl.addTarget(self, action: #selector(changeSelectedTeam(_:)), for: .valueChanged)

    }
    
    @objc func changeSelectedTeam(_ sender: UISegmentedControl)
    {
        tableOfShots.reloadData()
    }
    
    
    func setTableOfShots()
    {
        tableOfShots.snp.makeConstraints
        {
            make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(selectTeamControl.snp.bottom).offset(30)
        }
        
        tableOfShots.register(CellToHistory.self, forCellReuseIdentifier: "idCell")
        tableOfShots.dataSource = self
        tableOfShots.delegate = self
        
        

        tableOfShots.backgroundColor = .systemGray5
        tableOfShots.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section != 0
        {
            let selectedIndex = selectTeamControl.selectedSegmentIndex
            let selectedTeam = selectTeamControl.titleForSegment(at: selectedIndex)!
            let count = presenter.getCountOfAttacksByTeam(nameOfTeam: selectedTeam)
            return count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! CellToHistory
        cell.backgroundColor = UIColor(red: 255/255, green: 197/255, blue: 242/255, alpha: 1)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if let newCell = cell as? CellToHistory
        {
            let selectedIndex = selectTeamControl.selectedSegmentIndex
            let selectedTeam = selectTeamControl.titleForSegment(at: selectedIndex)!
            if indexPath.section != 0
            {
                let info = presenter.getAttacksByTeam(nameOfTeam: selectedTeam, id: indexPath.row)
                newCell.setInfo(info: info )
            }
            else
            {
                newCell.setInfo(info: ["Attack", "Time", "Zone", "Player", "Status"])
            }
        }
        
    }
    
    
    
}
