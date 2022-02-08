//
//  ViewController.swift
//  ShallWePlayaGame?
//
//  Created by Ian on 2022/2/5.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Board: GridView!
    @IBOutlet var Squares: [UIView]!
    @IBOutlet var InfoButton: UIButton!
    @IBOutlet var InfoFrame: UIView!
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myButton: UIButton!
    
    
    
    @IBOutlet var opiece: UILabel!
    @IBOutlet var xpiece: UILabel!
    var checkList: [String] = ["e","e", "e", "e", "e", "e", "e", "e", "e"]
    let grid: Grid = Grid()
    var pieceView: [UILabel] = []
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(xhandlePan(_:)))
        
        let panGesture1 = UIPanGestureRecognizer(target: self,
                                                action: #selector(ohandlePan(_:)))
        
        let action = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap(_:)))
        
        
        action.numberOfTapsRequired = 1
        InfoButton.addGestureRecognizer(action)
        
        
        opiece.alpha = 0.5
        xpiece.alpha = 0.5
        notice(xpiece)
        xpiece.addGestureRecognizer(panGesture)
        
        opiece.addGestureRecognizer(panGesture1)
        
        

    }
    
    func initGamex(){
        
        xpiece.alpha = 1
        xpiece = createNewX(xpiece)
        
        opiece.alpha = 0.5
        xpiece.alpha = 0.5
        print("before notice")
        opiece.isUserInteractionEnabled = false
        xpiece.isUserInteractionEnabled = false
        notice(xpiece)
        print("after notice")
        
    }
    
    func initGameo(){
        
        opiece.alpha = 0.5
        opiece = createNewO(opiece)
        
        opiece.alpha = 0.5
        xpiece.alpha = 0.5
        print("before notice")
        opiece.isUserInteractionEnabled = false
        xpiece.isUserInteractionEnabled = false
        notice(xpiece)
        print("after notice")
        
    }
    func notice(_ label: UILabel){
        label.alpha = 1
        let rotate = CGAffineTransform(rotationAngle: 45)
        label.transform = rotate
        UIView.animate(withDuration: 1,
                     delay: 0,
                       options: [.curveLinear],
                     animations: {
            label.transform = .identity
            
        }, completion: { _ in
            label.isUserInteractionEnabled = true
            print("Rotation complete")
            
        })
    }
    @objc func xhandlePan(_ recognizer:UIPanGestureRecognizer) {
      
        //let center = xpiece.center
      // Determine where the view is in relation to the superview
      let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
          // Set the view's center to the new position
          view.center = CGPoint(x:view.center.x + translation.x,
                                y:view.center.y + translation.y)
            // Reset the translation back to zero, so we are dealing in offsets
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            var tag = 0
            var flag = false
            if recognizer.state == UIGestureRecognizer.State.ended {
                for square in Squares{
                    let overlap = square.frame.intersects(xpiece.frame.inset(by: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)))
                    if overlap && checkList[tag] == "e"{
                        checkList[tag] = "x"
                        pieceView.append(xpiece)
                        
                        grid.checkSquare[tag] = "x"
                        flag = true
                        xpiece.isUserInteractionEnabled = false
                        
                        UIView.animate(withDuration: 1.0,
                                     delay: 0.1,
                                       options: [.curveLinear],
                                     animations: {
                                    self.xpiece.center = square.center
                                                 
                        }, completion: { _ in
                        
                        print("Snap X into the square complete")
                        })
                        let who = grid.checkWinOrTie()
                        if who == "x" || who == "o" || who == "tie"{
                            if who == "x"{
                                myLabel.text = "X is winner!~"
                            }
                            else if who == "o"{
                                myLabel.text = "O is winner!~"
                            }
                            else{
                                myLabel.text = "It is Tie!~"
                            }
                            checkList=["e","e", "e", "e", "e", "e", "e", "e", "e"]
                            grid.checkSquare = ["e","e", "e", "e", "e", "e", "e", "e", "e"]
                            UIView.animate(withDuration: 2.0,
                                         delay: 0.25,
                                           options: [.curveLinear],
                                         animations: {
                                        self.InfoFrame.alpha = 1
                                        self.InfoFrame.center = self.view.center
                                                     
                            }, completion: { [self] _ in
                            
                            print("Final Animation complete")
                                let dismiss = UITapGestureRecognizer(target: self,
                                                                     action: #selector(self.handleTap2(_:)))
                                
                                dismiss.numberOfTapsRequired = 1
                                self.myButton.addGestureRecognizer(dismiss)
                            })
                            return
                        }
                        xpiece.alpha = 0.5
                        xpiece = createNewX(xpiece)
                        notice(opiece)
                        print(checkList)
                        return
                    }
                    tag += 1
                }
                if (!flag){
                    let locat = CGPoint(x: 75, y: 673)
                    UIView.animate(withDuration: 1.0,
                                 delay: 0.1,
                                   options: [.curveLinear],
                                 animations: {
                        self.xpiece.center = locat
                    }, completion: { _ in
                    print("Go back to origin position.")
                    })
                }
            }
        }
        
    }

    @objc func ohandlePan(_ recognizer:UIPanGestureRecognizer) {
     
        //let center = opiece.center
      // Determine where the view is in relation to the superview
      let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
          // Set the view's center to the new position
          view.center = CGPoint(x:view.center.x + translation.x,
                                y:view.center.y + translation.y)
            // Reset the translation back to zero, so we are dealing in offsets
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            var tag = 0
            var flag = false
            if recognizer.state == UIGestureRecognizer.State.ended {
                for square in Squares{
                    let overlap = square.frame.intersects(opiece.frame.inset(by: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)))
                    if overlap && checkList[tag] == "e"{
                        checkList[tag] = "o"
                        pieceView.append(opiece)
                        print(pieceView)
                        grid.checkSquare[tag] = "o"
                        flag = true
                        opiece.isUserInteractionEnabled = false
                        UIView.animate(withDuration: 1.0,
                                     delay: 0.1,
                                       options: [.curveLinear],
                                     animations: {
                                    self.opiece.center = square.center
                        }, completion: { _ in
                        print("Snap O into the square complete")
                        })
                        let who = grid.checkWinOrTie()
                        if who == "x" || who == "o" || who == "tie"{
                            if who == "x"{
                                myLabel.text = "X is winner!~"
                            }
                            else if who == "o"{
                                myLabel.text = "O is winner!~"
                            }
                            else{
                                myLabel.text = "It is Tie!~"
                            }
                            checkList=["e","e", "e", "e", "e", "e", "e", "e", "e"]
                            grid.checkSquare = ["e","e", "e", "e", "e", "e", "e", "e", "e"]
                            UIView.animate(withDuration: 2.0,
                                         delay: 0.25,
                                           options: [.curveLinear],
                                         animations: {
                                        self.InfoFrame.alpha = 1
                                        self.InfoFrame.center = self.view.center
                            }, completion: { _ in
                            print("Final Animation complete")
                                let dismiss = UITapGestureRecognizer(target: self,
                                                                     action: #selector(self.handleTap3(_:)))
                                dismiss.numberOfTapsRequired = 1
                                self.myButton.addGestureRecognizer(dismiss)
                            })
                            return
                        }
                        opiece.alpha = 0.5
                        opiece = createNewO(opiece)
                        notice(xpiece)
                        print(checkList)
                        return
                    }
                    tag += 1
                }
                if (!flag){
                    let locat = CGPoint(x: 313, y: 673)
                    UIView.animate(withDuration: 1.0,
                                 delay: 0.1,
                                   options: [.curveLinear],
                                 animations: {
                        self.opiece.center = locat
                    }, completion: { _ in
                    print("Go back to origin position.")
                    
                    })
                }
            }
        }
    }
    
    func createNewX(_ label: UILabel) -> UILabel{
        let new_label = UILabel(frame: CGRect(x: 25, y: 623, width: 100, height: 100))
        new_label.textAlignment = .center
        new_label.text = "X"
        new_label.backgroundColor = label.backgroundColor
        new_label.font = label.font
        new_label.textColor = label.textColor
        new_label.alpha = 0.5
        new_label.isUserInteractionEnabled = false
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(self.xhandlePan(_:)))
        new_label.addGestureRecognizer(panGesture)
        self.view.addSubview(new_label)
        return new_label
    }
    
    func createNewO(_ label: UILabel) -> UILabel{
        let new_label = UILabel(frame: CGRect(x: 263, y: 623, width: 100, height: 100))
        new_label.textAlignment = .center
        new_label.text = "O"
        new_label.backgroundColor = label.backgroundColor
        new_label.font = label.font
        new_label.textColor = label.textColor
        new_label.alpha = 0.5
        new_label.isUserInteractionEnabled = false
        let panGesture1 = UIPanGestureRecognizer(target: self,
                                                action: #selector(self.ohandlePan(_:)))
        new_label.addGestureRecognizer(panGesture1)
        self.view.addSubview(new_label)
        return new_label
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        
        // Simple animation using UIView.animate
        
        UIView.animate(withDuration: 2.0,
                     delay: 0.25,
                       options: [.curveLinear],
                     animations: {
                    self.InfoFrame.alpha = 1
                    self.InfoFrame.center = self.view.center
        }, completion: { _ in
        print("Animation complete")
        })
        let dismiss = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap1(_:)))
        dismiss.numberOfTapsRequired = 1
        myButton.addGestureRecognizer(dismiss)
    }
    
    @objc func handleTap1(_ gestureRecognizer: UIGestureRecognizer) {
        UIView.animate(withDuration: 2.0,
                     delay: 0.25,
                       options: [.curveLinear],
                     animations: {
                    self.InfoFrame.alpha = 1
                    self.InfoFrame.center.y = 900
        }, completion: { _ in
            self.InfoFrame.frame = CGRect(x: 47, y: -200, width: 300, height: 112)
            self.myLabel.text = "Get 3 in a row to win!"
        print("Dismiss complete")
        })
    }
    
    @objc func handleTap2(_ gestureRecognizer: UIGestureRecognizer) {
        UIView.animate(withDuration: 2.0,
                     delay: 0.25,
                       options: [.curveLinear],
                     animations: {
                    self.InfoFrame.alpha = 1
                    self.InfoFrame.center.y = 900
        }, completion: { _ in
            self.InfoFrame.frame = CGRect(x: 47, y: -200, width: 300, height: 112)
            self.myLabel.text = "Get 3 in a row to win!"
            for piece in self.pieceView {
                piece.removeFromSuperview()
            }
            self.initGamex()
        })
    }
    @objc func handleTap3(_ gestureRecognizer: UIGestureRecognizer) {
        UIView.animate(withDuration: 2.0,
                     delay: 0.25,
                       options: [.curveLinear],
                     animations: {
                    self.InfoFrame.alpha = 1
                    self.InfoFrame.center.y = 900
                                 
        }, completion: { _ in
            self.InfoFrame.frame = CGRect(x: 47, y: -200, width: 300, height: 112)
            self.myLabel.text = "Get 3 in a row to win!"
            for piece in self.pieceView {
                piece.removeFromSuperview()
            }
            self.initGameo()
        
        })
    }

}
