//
//  ChessViewController+View.swift
//  iOS - Chessboard
//
//  Created by Mario Malamas on 15/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import Foundation
import UIKit

extension ChessViewController: ChessView {    
    var startPosition: Position? {
        return startingPosition
    }
    
    var endPosition: Position? {
        return endingPosition
    }
    
    var boardSize: Int {
        if N < 6 || N > 16 {
            fatalError("The board size must be between 6 and 16 (6 and 16 included)")
        }
        return N
    }
    
    func startEndPositionNotProvided() {
        let alert = UIAlertController(
            title: "Please select a start and an end position",
            message: nil,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func moveNotFound() {
        let alert = UIAlertController(
            title: "Impossible move for the knight",
            message: nil,
            preferredStyle: .alert
        )
        
        let defaultAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.reset()
        }
        
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func moveFound(moves: [Position]) {
        let alert = UIAlertController(
            title: "Move found",
            message: nil,
            preferredStyle: .alert
        )
        
        let displayAction = UIAlertAction(title: "Show", style: .default) { (action) in
            var delay: Int = 0
            for each in moves {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
                    self.setKnightPiece(position: each)
                }
                delay += 200
            }
        }
        
        alert.addAction(displayAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
