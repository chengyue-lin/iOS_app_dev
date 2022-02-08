//
//  InfoView.swift
//  ShallWePlayaGame?
//
//  Created by Ian on 2022/2/6.
//

import UIKit

class InfoView: UIView {


    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        //code
        
        //self.frame = CGRect(x: 47, y: -200, width: 300, height: 112)
        self.layer.backgroundColor = UIColor.orange.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 30
        self.layer.borderColor = UIColor.white.cgColor
        
        
        
        
    }

}
