//
//  ViewPresenter.swift
//  iOS - Chessboard
//
//  Created by Mario Malamas on 15/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import Foundation

class ChessViewPresenter {
    typealias View = ChessView
    private weak var _view: View!
    
    private let _knightMoves: [PossibleMove] = [
        .init(
            finalMove: .init(column: -2, row: -1),
            move1: .init(column: -1, row: 0),
            move2: .init(column: -2, row: 0)
        ),
        .init(
            finalMove: .init(column: -2, row: 1),
            move1: .init(column: -1, row: 0),
            move2: .init(column: -2, row: 0)
        ),
        .init(
            finalMove: .init(column: -1, row: -2),
            move1: .init(column: 0, row: -1),
            move2: .init(column: 0, row: -2)
        ),
        .init(
            finalMove: .init(column: -1, row: 2),
            move1: .init(column: 0, row: 1),
            move2: .init(column: 0, row: 2)
        ),
        .init(
            finalMove: .init(column: 1, row: -2),
            move1: .init(column: 0, row: -1),
            move2: .init(column: 0, row: -2)
        ),
        .init(
            finalMove: .init(column: 1, row: 2),
            move1: .init(column: 0, row: 1),
            move2: .init(column: 0, row: 2)
        ),
        .init(
            finalMove: .init(column: 2, row: -1),
            move1: .init(column: 1, row: 0),
            move2: .init(column: 2, row: 0)
        ),
        .init(
            finalMove: .init(column: 2, row: 1),
            move1: .init(column: 1, row: 0),
            move2: .init(column: 2, row: 0)
        )
    ]
        
    init(view: View) {
        _view = view
    }
}

extension ChessViewPresenter {
    func findPossibilities() {
        guard
            let startPosition = _view.startPosition,
            let endPosition = _view.endPosition
        else {
            _view.startEndPositionNotProvided()
            return
        }
        var knightMove: PossibleMove?
        for each in _knightMoves {
            let move = nextMove(from: startPosition, to: each.finalMove)
            if !isMoveValid(position: move) {
                continue
            }
            if move == endPosition {
                knightMove = each
                break
            }
        }
        guard let possibleMove = knightMove else {
            _view.moveNotFound()
            return
        }
        onSolutionFound(
            start: startPosition,
            end: endPosition,
            move: possibleMove
        )
    }
    
    private func onSolutionFound(start: Position, end: Position, move: PossibleMove) {
        var move1 = start
        var move2 = start
        // MOVE 1
        move1.column += move.move1.column
        move1.row += move.move1.row
        
        // MOVE 2
        move2.column += move.move2.column
        move2.row += move.move2.row
        _view.moveFound(moves: [start, move1, move2, end])
    }
        
    private func isMoveValid(position: Position) -> Bool {
        if position.column >= 0 && position.row >= 0 && position.column < _view.boardSize && position.row < _view.boardSize {
            return true
        }
        return false
    }
    
    private func nextMove(from: Position, to: Position) -> Position {
        return .init(
            column: from.column + to.column,
            row: from.row + to.row
        )
    }
}
