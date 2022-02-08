//
//  Grid.swift
//  ShallWePlayaGame?
//
//  Created by Ian on 2022/2/7.
//

import Foundation
import UIKit

class Grid{
    var checkSquare: [String] = ["e","e","e","e","e","e","e","e","e"]
    // I have a checkList in the viewcontroller, how can I associate with it?
    
    func checkWinOrTie() -> String{
        if(checkSquare[0]=="x" && checkSquare[1]=="x" && checkSquare[2]=="x") ||
            (checkSquare[3]=="x" && checkSquare[4]=="x" && checkSquare[5]=="x") ||
            (checkSquare[6]=="x" && checkSquare[7]=="x" && checkSquare[8]=="x") ||
            (checkSquare[0]=="x" && checkSquare[3]=="x" && checkSquare[6]=="x") ||
            (checkSquare[1]=="x" && checkSquare[4]=="x" && checkSquare[7]=="x") ||
            (checkSquare[2]=="x" && checkSquare[5]=="x" && checkSquare[8]=="x") ||
            (checkSquare[0]=="x" && checkSquare[4]=="x" && checkSquare[8]=="x") ||
            (checkSquare[2]=="x" && checkSquare[4]=="x" && checkSquare[6]=="x") {
            print("X wins!~")
            return "x"
            //myLabel.text = "Congratulations, X wins!~"
            
            
        }
        else if(checkSquare[0]=="o" && checkSquare[1]=="o" && checkSquare[2]=="o") ||
                (checkSquare[3]=="o" && checkSquare[4]=="o" && checkSquare[5]=="o") ||
                (checkSquare[6]=="o" && checkSquare[7]=="o" && checkSquare[8]=="o") ||
                (checkSquare[0]=="o" && checkSquare[3]=="o" && checkSquare[6]=="o") ||
                (checkSquare[1]=="o" && checkSquare[4]=="o" && checkSquare[7]=="o") ||
                (checkSquare[2]=="o" && checkSquare[5]=="o" && checkSquare[8]=="o") ||
                (checkSquare[0]=="o" && checkSquare[4]=="o" && checkSquare[8]=="o") ||
                (checkSquare[2]=="o" && checkSquare[4]=="o" && checkSquare[6]=="o"){
            print("O wins!~")
            return "o"
                //myLabel.text = "Congratulations, O wins!~"
            
        }else if (checkSquare[0] != "e") && (checkSquare[1] != "e") && (checkSquare[2] != "e") && (checkSquare[3] != "e") && (checkSquare[4] != "e") && (checkSquare[5] != "e") && (checkSquare[6] != "e") && (checkSquare[7] != "e") && (checkSquare[8] != "e"){
            print("It is Tie!~")
            return "tie"
        }
        return ""
    }
}
