//
//  ChessView.swift
//  iOS - Chessboard
//
//  Created by Mario Malamas on 15/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import Foundation

protocol ChessView:class {
    var startPosition: Position? {get}
    var endPosition: Position? {get}
    var boardSize: Int {get}
    func startEndPositionNotProvided()
    func moveNotFound()
    func moveFound(moves: [Position])
}
