//
//  Position.swift
//  iOS - Chessboard
//
//  Created by Mario Malamas on 15/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import Foundation

struct Position {
    var column: Int
    var row: Int
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
}

extension Position: Equatable {
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}
