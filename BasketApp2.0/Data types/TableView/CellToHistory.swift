//
//  CellToHistory.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.02.2022.
//

import UIKit

class CellToHistory: UITableViewCell
{
    // Attack, Time, Zone, Player, Status
    private var titlesForLabels = ["Attack", "Time", "Zone", "Player", "Status"]
    private var numOfAttack = UILabel()
    private var time = UILabel()
    private var zone = UILabel()
    private var player = UILabel()
    private var status = UILabel()
    
    private var widthForLabels: CGFloat = 0
    private var insetForLabels: CGFloat = 0
    
    override func layoutSubviews()
    {
        var count: CGFloat = 1
        let array = [numOfAttack, time, zone, player, status]
        for i in 0...array.count - 1
        {
            self.contentView.addSubview(array[i])
            array[i].frame.size = CGSize(width: (self.contentView.frame.width / 5) * 0.9, height: self.contentView.frame.height * 0.9)
            array[i].center = CGPoint(x: (self.contentView.frame.width / 10 * count) , y: self.contentView.center.y)
//            item.text = "18"
            array[i].textAlignment = .center
            array[i].text = titlesForLabels[i]
            count += 2
        }
        
        
        widthForLabels = (self.frame.width / 5) * 0.9
        insetForLabels = widthForLabels * 0.1
        
    }
    // info[Attack, Time, Zone, Player, Status]
    /// setInfo
    /// - Parameter info: info about shot. NEED line like info[Attack, Time, Zone, Player, Status]
    func setInfo(info: [String])
    {
        let array = [numOfAttack, time, zone, player, status]
        for i in 0...array.count - 1
        {
            titlesForLabels[i] = info[i]
        }
    }

}
