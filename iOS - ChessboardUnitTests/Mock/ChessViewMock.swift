//
//  ChessViewMock.swift
//  iOS - ChessboardUnitTests
//
//  Created by Mario Malamas on 16/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import Foundation
@testable import iOS___Chessboard

final class ChessViewMock: ChessView {
    
    private let _N: Int
    
    private (set)var isMoveFound: Bool = false
    
    private (set)var isStartEndPositionProvided: Bool = false
    
    private (set)var startPosition: Position?
    
    private (set)var endPosition: Position?
    
    init(boardSize: Int) {
        _N  = boardSize
    }
    
    func setPositions(start: Position?, end: Position?) {
        startPosition = start
        endPosition = end
        isStartEndPositionProvided = startPosition != nil && endPosition != nil ? true : false
    }
    
    var boardSize: Int {
        if _N < 6 || _N > 16 {
            fatalError()
        }
        return _N
    }
    
    func moveNotFound() {
        isMoveFound = false
    }
    
    func moveFound(moves: [Position]) {
        isMoveFound = true
    }
    
    func startEndPositionNotProvided() {
        isStartEndPositionProvided = false
    }
}
