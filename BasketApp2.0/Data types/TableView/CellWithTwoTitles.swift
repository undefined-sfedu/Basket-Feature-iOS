//
//  GameCell.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import SnapKit
class CellWithTwoTitles: UITableViewCell
{
    // Title for name of game or player
    private var leftTitle = UILabel()
    // Title for date of game or num of player
    private var rightTitle = UILabel()
    
    override func layoutSubviews()
    {
        setLabels()
        
    }
    private func setLabels()
    {
        self.contentView.addSubview(leftTitle)
        self.contentView.addSubview(rightTitle)
        
        rightTitle.textAlignment = .center
        for item in [leftTitle, rightTitle]
        {
           
            item.snp.makeConstraints
            { maker in
                maker.height.equalTo(self.contentView.frame.height * 0.9)
                maker.centerY.equalTo(self.contentView.center.y)
                
                maker.width.equalTo(self.contentView.frame.width * 0.5)
                if item == leftTitle
                {
                    
                    maker.left.equalTo(10)
                }
                else
                {
                    maker.width.equalTo(self.contentView.frame.width * 0.5)
                    maker.right.equalTo(-10)
                }
            }
        }
    }
    
    var accessToLeftTitle: String
    {
        get
        {
            return self.leftTitle.text!
        }
        set
        {
            self.leftTitle.attributedText = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        }
    }
    
    var accessToRightTitle: String
    {
        get
        {
            return self.rightTitle.text!
        }
        set
        {
            self.rightTitle.attributedText = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        }
    }
    
}

