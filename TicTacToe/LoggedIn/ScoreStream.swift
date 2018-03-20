//
//  ScoreStream.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 19/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RxSwift

struct Score {
  let player1Score: Int
  let player2Score: Int
  
  static func equals(lhs: Score, rhs: Score) -> Bool {
    return lhs.player1Score == rhs.player1Score && lhs.player2Score == rhs.player2Score
  }

}

protocol ScoreStream {
  var score: Observable<Score> { get }
  
}

protocol MutableScoreStream: ScoreStream {
  func updateScore(withWinner winner: PlayerType)
}

class ScoreStreamImpl:MutableScoreStream {
  
  var score: Observable<Score> {
    return variable.asObservable().distinctUntilChanged({ (cur, new) -> Bool in
      return Score.equals(lhs: cur, rhs: new)
    })
  }
  
  func updateScore(withWinner winner: PlayerType) {
    let newScore:Score = {
      let currentScore = variable.value
      switch winner {
      case .player1:
        return Score(player1Score: currentScore.player1Score + 1, player2Score: currentScore.player2Score)
      default:
        return Score(player1Score: currentScore.player1Score, player2Score: currentScore.player2Score + 1)
      }
    }()
    variable.value = newScore
  }
  
  //MARK: -private
  private let variable = Variable<Score>(Score(player1Score: 0, player2Score: 0))
}
