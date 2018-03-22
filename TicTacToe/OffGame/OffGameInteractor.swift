//
//  OffGameInteractor.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 10/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
  weak var listener: OffGamePresentableListener? { get set }
  func set(score: Score)
}

protocol OffGameListener: class {
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {
  
  
  weak var router: OffGameRouting?
  weak var listener: OffGameListener?
  
  init(presenter: OffGamePresentable, scoreStream: ScoreStream) {
    self.scoreStream = scoreStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    updateScore()
  }
  
  override func willResignActive() {
    super.willResignActive()
  }
  
  //Mark: - OffGamePresentableListener
  func startGame() {
    
  }
  
  
  //Mark: - private
  private let scoreStream:ScoreStream
  
  private func updateScore() {
    scoreStream.score
      .subscribe(
        onNext: { (score: Score) in
          self.presenter.set(score: score)
      })
      .disposeOnDeactivate(interactor: self)
  }
}

