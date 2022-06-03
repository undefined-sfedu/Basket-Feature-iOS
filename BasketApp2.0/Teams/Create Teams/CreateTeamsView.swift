//
//  CreateTeamsView.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import UIKit
import SnapKit
class CreateTeamsView: UIViewController
{
    private let presenter = CreateTeamsPresenter()
    
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    
    private let teamNameTextField = UITextField()
    private let sliderForCountOfPlayer = UISlider()
    private var tableOfPlayers = UITableView()
    private let saveButton = UIButton()

        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        presenter.setView(view: self)
        setSizeVariables()
        setView()
//        presenter.setView(view: self)
        
        
        setTeamNameField()
        setSaveButton()
        
        for item in [teamNameTextField, saveButton]
        {
            self.view.addSubview(item)
        }
        
//        setPositionOfViews(ratioAndView: [1:teamNameTextField, 2.3:saveButton])
        setPositionOfViews(ratioAndView: [1:teamNameTextField, 2.3:sliderForCountOfPlayer, 3.6:tableOfPlayers, 4.9:saveButton])
    }
    
    private func setView()
    {
        self.title = "Create Team"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .never
        self.tabBarController?.tabBar.isHidden = true
    }
    private func setSizeVariables()
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
    
    func alertAboutEmptyNameOfTeam()
    {
        teamNameTextField.text = ""
        let alert = UIAlertController(title: "Attention", message: "You didn't write name of team", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    func hideView()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setTeamNameField()
    {
        self.teamNameTextField.layer.borderColor = UIColor.black.cgColor
        self.teamNameTextField.layer.borderWidth = 1
        self.teamNameTextField.placeholder = "Team name"
    }
    
    private func setSlider()
    {
        self.sliderForCountOfPlayer.minimumValue = 5
        self.sliderForCountOfPlayer.maximumValue = 15
        self.sliderForCountOfPlayer.value = 5
    }
    
//    private func setTableOfPlayer()
//    {
//        self.tableOfPlayers = UITableView(frame: <#T##CGRect#>, style: <#T##UITableView.Style#>)
//    }
    
    
    private func setSaveButton()
    {
        self.saveButton.backgroundColor = UIColor(red: 253/255, green: 121/255, blue: 192/255, alpha: 1)
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.titleLabel?.attributedText = NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        self.saveButton.setTitleColor(.black, for: .normal)
        self.saveButton.addTarget(self, action: #selector(saveTeamMethod(_:)), for: .touchDown)
    }
   
    @objc private func saveTeamMethod(_ sender: UIButton)
    {
        
//        presenter.addTeam(nameOfTeam: teamNameTextField.text!)
    }
   
}
