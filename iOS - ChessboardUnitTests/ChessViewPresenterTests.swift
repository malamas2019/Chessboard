//
//  ChessViewPresenterTests.swift
//  iOS - ChessboardUnitTests
//
//  Created by Mario Malamas on 16/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import XCTest
@testable import iOS___Chessboard

class ChessViewPresenterTests: XCTestCase {
    
    var presenter: ChessViewPresenter!
    
    var view: ChessViewMock!
    
    override func setUpWithError() throws {
        view = ChessViewMock(boardSize: 8)
        presenter = ChessViewPresenter(view: view)
    }

    override func tearDownWithError() throws {
        presenter = nil
        view = nil
    }
    
    func test_find_possibilities_success() {
        // Given
        view.setPositions(start: .init(column: 0, row: 0), end: .init(column: 1, row: 2))
        
        // When
        presenter.findPossibilities()
        
        // Then
        XCTAssertTrue(view.isStartEndPositionProvided)
        XCTAssertTrue(view.isMoveFound)
    }
    
    func test_possibilities_not_found() {
        // Given
        view.setPositions(start: .init(column: 3, row: 3), end: .init(column: 3, row: 2))
        
        // When
        presenter.findPossibilities()
        
        // Then
        XCTAssertTrue(view.isStartEndPositionProvided)
        XCTAssertFalse(view.isMoveFound)
    }
    
    func test_start_and_end_not_provided() {
        // Given
        view.setPositions(start: nil, end: .init(column: 3, row: 2))
        
        // When
        presenter.findPossibilities()
        
        // Then
        XCTAssertFalse(view.isStartEndPositionProvided)
    }
}
