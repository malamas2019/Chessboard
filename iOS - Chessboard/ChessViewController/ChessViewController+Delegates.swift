//
//  ViewController+UICollectionViewDelegate.swift
//  iOS - Chessboard
//
//  Created by Mario Malamas on 15/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import Foundation
import UIKit

extension ChessViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return boardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        )
        if indexPath.section % 2 == 0 {
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .black
        } else {
            cell.backgroundColor = indexPath.row % 2 == 0 ? .black : .lightGray
        }
        // KNIGHT
        if let knightPosition = currentKnightPosition {
            let cellPosition: Position = .init(
                column: indexPath.row,
                row: indexPath.section
            )
            if knightPosition == cellPosition {
                cell.addSubview(knightImageView)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        if !isStartPositionSelected {
            isStartPositionSelected = true
            startingPosition = .init(column: indexPath.row, row: indexPath.section)
            cell.backgroundColor = startingPositionColor
        } else if !isEndPositionSelected {
            if let startPosition = startPosition, startPosition == .init(column: indexPath.row, row: indexPath.section) {
                /// prevent the selection of end position as starting position
                return
            }
            isEndPositionSelected = true
            endingPosition = .init(column: indexPath.row, row: indexPath.section)
            cell.backgroundColor = endingPositionColor
            self.presenter.findPossibilities()
        }
    }
}

extension ChessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / CGFloat(boardSize)
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
