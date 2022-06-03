//
//  ViewController.swift
//  createTeamViewTest
//
//  Created by Daniil on 10.02.2022.
//

import UIKit
import SnapKit
class CreateTeamsView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private let presenter = CreateTeamsPresenter()
    private let offsetForViews = 30
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    private var sizeForFields: CGSize = CGSize(width: 0, height: 0)
    
    private let fieldOfName = UITextField()
    private let slider = UISlider()
    private var tableOfPlayers = UITableView(frame: CGRect(), style: .insetGrouped)
    private let createTeamButton = UIButton()
    
    private var numsOfPlayers: Array<String> = Array.init(repeating: "", count: 5)
    
    private var countOfPlayers = 5
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        for item in [fieldOfName, slider, tableOfPlayers, createTeamButton]
        {
            self.view.addSubview(item)
        }
        setSizeVariables()
        setView()
        setFieldOfName()
        setSlider()
        setTableOfPlayer()
        setButton()
        
        
    }
    
    private func setView()
    {
        presenter.setView(view: self)
        self.title = "Create team"
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.largeTitleDisplayMode = .never
    }
    private func setSizeVariables()
    {
        heightForFields = self.view.frame.height / 14
        widthForFields = self.view.frame.width * 0.9
        sizeForFields = CGSize(width: widthForFields, height: heightForFields)
    }
    
    func setFieldOfName()
    {
        fieldOfName.snp.makeConstraints
        {
            make in
            make.width.equalTo(sizeForFields.width)
            make.height.equalTo(sizeForFields.height)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(offsetForViews)
            
           
        }
        fieldOfName.layer.borderWidth = 1
        fieldOfName.layer.cornerRadius = 14
        fieldOfName.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        fieldOfName.placeholder = "Team name"
        
    }
    
    func setSlider()
    {
        slider.snp.makeConstraints
        {
            make in
            make.width.equalTo(sizeForFields.width)
            make.height.equalTo(sizeForFields.height)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(fieldOfName.snp.bottom).offset(offsetForViews)
            
            
        }
        slider.maximumValue = 15
        slider.minimumValue = 5
        
//        var minimumValueImage = UIImage(named: "man")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(red: 255/255, green: 121/255, blue: 192/255, alpha: 1))
        slider.minimumValueImage = UIImage(named: "man")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(red: 255/255, green: 121/255, blue: 192/255, alpha: 1))
        
        slider.maximumValueImage = UIImage(named: "people")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(red: 255/255, green: 121/255, blue: 192/255, alpha: 1))
        slider.minimumTrackTintColor = UIColor(red: 255/255, green: 121/255, blue: 192/255, alpha: 1)
        slider.value = 5
        slider.addTarget(self, action: #selector(sliderSelector(_:)), for: .valueChanged)
    }
    
    @objc func sliderSelector(_ sender: UISlider)
    {
        sender.value = Float(Int(sender.value))
        if Int(sender.value) > numsOfPlayers.count
        {
            while Int(sender.value) != numsOfPlayers.count
            {
                numsOfPlayers.append("")
            }
            
        }
        else
        {
            
            while Int(sender.value) != numsOfPlayers.count
            {
                numsOfPlayers.removeLast()
            }
        }
        
        self.tableOfPlayers.reloadData()
        self.countOfPlayers = Int(sender.value)
        
        
    }
    
    
    func setTableOfPlayer()
    {
        tableOfPlayers.snp.makeConstraints
        {
            make in
            make.width.equalTo(sizeForFields.width)
            make.height.equalTo(sizeForFields.height * 6)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(slider.snp.bottom).offset(offsetForViews)
        }
        
        tableOfPlayers.showsHorizontalScrollIndicator = false
        tableOfPlayers.showsVerticalScrollIndicator = false
        tableOfPlayers.layer.cornerRadius = 14
        tableOfPlayers.backgroundColor = UIColor(red: 255/255, green: 121/255, blue: 192/255, alpha: 1)
        tableOfPlayers.dataSource = self
        tableOfPlayers.delegate = self
        tableOfPlayers.register(UITableViewCell.self, forCellReuseIdentifier: "idCell")
    }
    
    func alertAboutEmptyNameOfTeam()
    {
        fieldOfName.text = ""
        let alert = UIAlertController(title: "Attention", message: "You didn't write name of team", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertAboutWrongPlayer()
    {
        let alert = UIAlertController(title: "Attention", message: "You've written uncorrect number of player", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertAboutExistingTeam()
    {
        fieldOfName.text = ""
        let alert = UIAlertController(title: "Attention", message: "Teams with this name are in your teams", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideView()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setButton()
    {
        createTeamButton.snp.makeConstraints
        {
            make in
            make.topMargin.equalTo(tableOfPlayers.snp.bottom).offset(offsetForViews)
            make.centerX.equalToSuperview()
            make.width.equalTo(sizeForFields.width)
            make.height.equalTo(sizeForFields.height)
        }
        createTeamButton.setTitle("Create team", for: .normal)
        createTeamButton.setTitleColor(.black, for: .normal)
        createTeamButton.layer.cornerRadius = 14
        createTeamButton.backgroundColor = UIColor(red: 255/255, green: 121/255, blue: 192/255, alpha: 1)
        createTeamButton.addTarget(self, action: #selector(createTeam(_:)), for: .touchDown)
    }
    
    @objc func createTeam(_ sender: UIButton)
    {
        var idOfVisibleCell = 0
        var textFieldFromVisibleCell = UITextField()
        for item in tableOfPlayers.visibleCells
        {
            idOfVisibleCell = (tableOfPlayers.indexPath(for: item))!.row
            textFieldFromVisibleCell = tableOfPlayers.cellForRow(at: IndexPath(row: idOfVisibleCell, section: 0))!.contentView.subviews[0] as! UITextField
            numsOfPlayers[idOfVisibleCell] = textFieldFromVisibleCell.text!
        }
        presenter.addTeam(nameOfTeam: fieldOfName.text!, players: &numsOfPlayers)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numsOfPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        
        if cell.contentView.subviews.count == 0
        {
            let textField = UITextField()
            textField.frame.size = cell.frame.size
            textField.keyboardType = .numberPad
            cell.contentView.addSubview(textField)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let newCell = cell.contentView.subviews[0] as? UITextField
        newCell!.placeholder = " \(numsOfPlayers.count - indexPath.row)) Enter num of player"
        newCell!.text = numsOfPlayers[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let newCell = cell.contentView.subviews[0] as? UITextField
        if indexPath.row < numsOfPlayers.count
        {
            numsOfPlayers[indexPath.row] = newCell!.text!
        }
    }
    
}

