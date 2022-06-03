//
//  NumOfPlayerCell.swift
//  BasketApp2.0
//
//  Created by Daniil on 07.03.2022.
//

import UIKit

class NumOfPlayerCell: UICollectionViewCell
{
    private let label = UILabel()
    
    override func layoutSubviews()
    {
        super.layoutSubviews()

    }
    
    override func didAddSubview(_ subview: UIView)
    {
        super.didAddSubview(subview)
        
    }
    
    func setLabelView(name: String)
    {
        if self.contentView.subviews.first == nil
        {
            label.frame = self.contentView.frame
            label.textAlignment = .center
            label.layer.cornerRadius = label.frame.height / 2
            
            self.contentView.addSubview(label)
        }
        
        label.text = name
        
    }
    
    var accessToNumOfPlayer: String
    {
        get
        {
            let newLabel = self.contentView.subviews.first! as! UILabel
            return newLabel.text!
        }
        set
        {
            
            label.text = newValue
        }
        
    }
    
}
