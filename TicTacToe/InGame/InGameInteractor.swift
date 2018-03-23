//
//  InGameInteractor.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 13/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol InGameRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol InGamePresentable: Presentable {
  weak var listener: InGamePresentableListener? { get set }
  func setCell(atRow: Int, col: Int, withPlayerType: PlayerType)
}

protocol InGameListener: class {
//  func gameDidEnd(withWinner winner:PlayerType)
  
}

final class InGameInteractor: PresentableInteractor<InGamePresentable>, InGameInteractable, InGamePresentableListener {
  
  weak var router: InGameRouting?
  weak var listener: InGameListener?
  
  override init(presenter: InGamePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    initBoard()
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func placeCurrentPlayerMark(atRow row: Int, col: Int){
    guard board[row][col] == nil else {
      return
    }
    board[row][col] = currentPlayer
    presenter.setCell(atRow: row, col: col, withPlayerType: currentPlayer)
    self.currentPlayer = (currentPlayer == .player1) ?  .player2 : .player1
  }
  
  func closeGame() {
    
  }
  
  //Mark: - private
  private var currentPlayer = PlayerType.player1
  private var board = [[PlayerType?]]()
  
  private func initBoard() {
    for _ in 0..<GameConstants.rowCount {
      board.append([nil, nil, nil])
    }
  }
  
  private func checkWinner() -> PlayerType? {
    // Rows.
    for row in 0..<GameConstants.rowCount {
      guard let assumedWinner = board[row][0] else {
        continue
      }
      var winner: PlayerType? = assumedWinner
      for col in 1..<GameConstants.colCount {
        if assumedWinner.rawValue != board[row][col]?.rawValue {
          winner = nil
          break
        }
      }
      if let winner = winner {
        return winner
      }
    }
    
    // Cols.
    for col in 0..<GameConstants.colCount {
      guard let assumedWinner = board[0][col] else {
        continue
      }
      var winner: PlayerType? = assumedWinner
      for row in 1..<GameConstants.rowCount {
        if assumedWinner.rawValue != board[row][col]?.rawValue {
          winner = nil
          break
        }
      }
      if let winner = winner {
        return winner
      }
    }
    
    // Diagnals.
    guard let p11 = board[1][1] else {
      return nil
    }
    if let p00 = board[0][0], let p22 = board[2][2] {
      if p00.rawValue == p11.rawValue && p11.rawValue == p22.rawValue {
        return p11
      }
    }
    
    if let p02 = board[0][2], let p20 = board[2][0] {
      if p02.rawValue == p11.rawValue && p11.rawValue == p20.rawValue {
        return p11
      }
    }
    
    return nil
  }
}

enum PlayerType: Int {
  case player1 = 1
  case player2
}

struct GameConstants {
  static let rowCount = 3
  static let colCount = 3
}

