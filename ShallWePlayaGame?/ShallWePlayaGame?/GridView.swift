//
//  GridView.swift
//  ShallWePlayaGame?
//
//  Created by Ian on 2022/2/5.
//

import UIKit

class GridView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path1 = UIBezierPath(rect: CGRect(x: 0.0, y: 118.0, width: 358.0, height: 5.0))
        UIColor.purple.setFill()
        path1.fill()
        path1.close()
        
        let path2 = UIBezierPath(rect: CGRect(x: 0.0, y: 236.0, width: 358.0, height: 5.0))
        UIColor.purple.setFill()
        path2.fill()
        path2.close()
        
        let path3 = UIBezierPath(rect: CGRect(x: 118.0, y: 0.0, width: 5.0, height: 357.0))
        UIColor.purple.setFill()
        path3.fill()
        path3.close()
        
        let path4 = UIBezierPath(rect: CGRect(x: 236.0, y: 0.0, width: 5.0, height: 357.0))
        UIColor.purple.setFill()
        path4.fill()
        path4.close()
    }
    

}
