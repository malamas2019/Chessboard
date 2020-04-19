//
//  ChessViewControllerTests.swift
//  iOS - ChessboardUITests
//
//  Created by Mario Malamas on 16/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import XCTest

class ChessViewControllerTests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_move_found() {
        // Given
        var isMovesShown: Bool = false
        
        app.launch()
        
        /// Make sure we're displaying the chess view controller
        XCTAssertTrue(app.isDisplayingChessView)
        
        /// Calculate boardSize
        let collectionViewWith = app.collectionViews.firstMatch.frame.width
        let cellSize = app.collectionViews.cells.firstMatch.frame.width
        let boardSize = Int(collectionViewWith / cellSize)
        
        /// Mark a start position for the knight
        app.collectionViews.cells.element(boundBy:0).tap()
        
        /// Mark a valid end position for the knight
        app.collectionViews.cells.element(boundBy:(boardSize * 2) + 1).tap()
        
        /// Show the moves when the alert appears
        addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
            let showButton = alert.buttons["Show"]
            if showButton.exists {
                showButton.tap()
                isMovesShown = true
                return true
            }
            return false
        }
        app.navigationBars.firstMatch.tap()
        
        /// Then
        sleep(1)
        XCTAssertTrue(isMovesShown)
    }
    
    func test_move_not_found() {
        var isMovesNotFound: Bool = false
        app.launch()
        
        /// Make sure we're displaying the chess view controller
        XCTAssertTrue(app.isDisplayingChessView)
        
        /// Mark a start position for the knight
        app.collectionViews.cells.element(boundBy:0).tap()
        
        //sleep(1)
        
        /// Mark a valid end position for the knight
        app.collectionViews.cells.element(boundBy:2).tap()
        
        /// Show the moves when the alert appears
        addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
            let showButton = alert.buttons["Ok"]
            if showButton.exists {
                showButton.tap()
                isMovesNotFound = true
                return true
            }
            return false
        }
        app.navigationBars.firstMatch.tap()
        
        /// Then
        XCTAssertTrue(isMovesNotFound)
    }
}

extension XCUIApplication {
    var isDisplayingChessView: Bool {
        return otherElements["ChessViewController"].exists
    }
}
