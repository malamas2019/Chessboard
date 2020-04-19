//
//  ViewController.swift
//  iOS - Chessboard
//
//  Created by Mario Malamas on 14/4/20.
//  Copyright © 2020 Mario Malamas. All rights reserved.
//

import UIKit

class ChessViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint!
    
    final let cellIdentifier: String = .init(describing: UICollectionViewCell.self)
    
    private let deviceWidth = UIScreen.main.bounds.size.width
    
    private var cellSize: CGFloat = 0.0
    
    var isStartPositionSelected: Bool = false
    var isEndPositionSelected: Bool = false
    
    var startingPosition: Position?
    var endingPosition: Position?
    
    var startingPositionColor: UIColor = .green
    var endingPositionColor: UIColor = .red
    
    var currentKnightPosition: Position?
    
    lazy var knightImageView: UIImageView = {
        let view = UIImageView(
            frame: .init(x: 0, y: 0, width: cellSize, height: cellSize)
        )
        view.image = UIImage(named: "knight")
        return view
    }()
    
    /// board size
    final let N: Int = 8
    
    var presenter: ChessViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ChessViewPresenter(view: self)
        setupView()
    }
    
    private func setupView() {
        self.title = "Chessboard"
        view.accessibilityIdentifier = String(describing: ChessViewController.self)
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.borderWidth = 0.5
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: cellIdentifier
        )
        cellSize = floor(deviceWidth / CGFloat(boardSize))
        let collectionViewWidth = CGFloat(boardSize) * cellSize
        collectionViewWidthConstraint.constant = collectionViewWidth
    }
    
    @IBAction func reset() {
        isStartPositionSelected = false
        isEndPositionSelected = false
        startingPosition = nil
        endingPosition = nil
        currentKnightPosition = nil
        knightImageView.removeFromSuperview()
        collectionView.reloadData()
    }
    
    func setKnightPiece(position: Position) {
        currentKnightPosition = position
        collectionView.reloadData()
    }
}
